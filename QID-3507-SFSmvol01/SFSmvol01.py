"""Daily EUR/USD and GBP/USD log returns, summary statistics and correlation.

Run: python SFSmvol01.py
Dependencies: numpy, matplotlib
Keep fx_eur_gbp_usd.txt beside this script.
"""
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np


def main():
    folder = Path(__file__).resolve().parent
    rates = np.loadtxt(folder / "fx_eur_gbp_usd.txt")
    if rates.ndim != 2 or rates.shape[1] != 2:
        raise ValueError("Expected two columns: EUR/USD and GBP/USD.")
    if not np.isfinite(rates).all() or (rates <= 0).any():
        raise ValueError("Exchange rates must be finite and strictly positive.")

    # Equivalent to the R matrix calculation, without constructing an n-by-n matrix.
    returns = np.diff(np.log(rates), axis=0)
    names = ("EUR/USD", "GBP/USD")
    print(f"Daily log returns ({len(returns)} observations)")
    print(f"{'Statistic':<12}{names[0]:>14}{names[1]:>14}")
    summaries = [
        ("Minimum", np.min(returns, axis=0)),
        ("1st quartile", np.quantile(returns, 0.25, axis=0)),
        ("Median", np.median(returns, axis=0)),
        ("Mean", np.mean(returns, axis=0)),
        ("3rd quartile", np.quantile(returns, 0.75, axis=0)),
        ("Maximum", np.max(returns, axis=0)),
        ("Std. dev.", np.std(returns, axis=0, ddof=1)),
    ]
    for label, values in summaries:
        print(f"{label:<12}{values[0]:>14.8f}{values[1]:>14.8f}")
    print("\nCorrelation matrix (EUR/USD, GBP/USD):")
    print(np.corrcoef(returns, rowvar=False))

    fig, axes = plt.subplots(2, 1, figsize=(8, 8), layout="constrained")
    # Retain the original R example's approximate year tick positions.
    ticks = [0, 261, 522, 784, 1044, 1304, 1565, 1827]
    years = [str(year) for year in range(2002, 2010)]
    observations = np.arange(1, len(returns) + 1)
    for column, (ax, name) in enumerate(zip(axes, names)):
        ax.plot(observations, returns[:, column], color="blue", linewidth=0.7)
        ax.set(title=name, xlabel="Time", ylabel="Log return", ylim=(-0.05, 0.05))
        ax.set_xticks(ticks, years)
        ax.set_xlim(0, max(len(returns), ticks[-1]))
    output = folder / "SFSmvol01.png"
    fig.savefig(output, dpi=200, transparent=True)
    plt.close(fig)
    print(f"\nSaved {output}")


if __name__ == "__main__":
    main()
