"""Reproduce QuantLet SFSbullspreadcall in Python with transparent exports.
Requires numpy and matplotlib. Premiums use Black–Scholes without dividends.
"""
from pathlib import Path
from math import erf, exp, log, sqrt
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

S0, K1, K2, T, sigma, r = 92., 100., 120., 1., .4, .03

def call_price(S, K, T, sigma, r):
    d1 = (log(S/K) + (r + sigma*sigma/2)*T)/(sigma*sqrt(T))
    d2 = d1 - sigma*sqrt(T)
    normal = lambda x: (1 + erf(x/sqrt(2)))/2
    return S*normal(d1) - K*exp(-r*T)*normal(d2)

c1, c2 = [call_price(S0, K, T, sigma, r) for K in (K1, K2)]
debit_T = (c1-c2)*exp(r*T)
st = np.unique(np.r_[np.linspace(70, 140, 701), K1, K2])
long = np.maximum(st-K1, 0) - c1*exp(r*T)
short = -np.maximum(st-K2, 0) + c2*exp(r*T)
profit = long + short
assert np.allclose(profit, np.clip(st-K1, 0, K2-K1)-debit_T)

plt.rcParams.update({'font.family':'DejaVu Sans', 'font.size':12})
fig, ax = plt.subplots(figsize=(8, 8), layout='constrained')
ink = '#24364b'
ax.axhline(0, color=ink, linewidth=.9, alpha=.5)
for k in (K1, K2):
    ax.axvline(k, color=ink, linewidth=.8, alpha=.2, linestyle=':')
ax.plot(st, long, '--', color='#3178b5', linewidth=1.8, label='Long call · K = 100')
ax.plot(st, short, '--', color='#a16c24', linewidth=1.8, label='Short call · K = 120')
ax.plot(st, profit, color='#d73749', linewidth=3.2, label='Bull call spread')
ax.scatter([K1, K2], [-debit_T, K2-K1-debit_T], color='#d73749', s=35, zorder=4)
ax.set(xlim=(70,140), ylim=(-25,35), xlabel=r'Underlying price at expiry, $S_T$', ylabel='Profit at expiry', title='Bull call spread')
ax.text(.02, .96, 'S₀ = 92   |   K₁ = 100   |   K₂ = 120   |   T = 1 year\nσ = 40%   |   r = 3%   |   no dividends', transform=ax.transAxes, va='top', color=ink, fontsize=10)
ax.text(.02, .035, f'Net premium today: {c1-c2:.2f}     •     Break-even at expiry: {K1+debit_T:.2f}\nPremiums compounded to expiry at r; excludes fees.', transform=ax.transAxes, color=ink, fontsize=10)
ax.legend(loc='upper right', frameon=False, labelcolor=ink, fontsize=10)
for side in ('top','right'):
    ax.spines[side].set_visible(False)
for side in ('bottom','left'):
    ax.spines[side].set_color(ink)
ax.tick_params(colors=ink)
ax.xaxis.label.set_color(ink)
ax.yaxis.label.set_color(ink)
ax.title.set_color(ink)
ax.title.set_fontsize(20)
ax.set_title('Bull call spread', pad=18, fontsize=20, color=ink)
fig.patch.set_alpha(0)
ax.patch.set_alpha(0)
out = Path(__file__).resolve().parent
for ext in ('png', 'svg'):
    fig.savefig(out / f'bull_call_spread.{ext}', transparent=True, dpi=300)
print(f'Call premiums: {c1:.6f}, {c2:.6f}; debit: {c1-c2:.6f}; expiry debit: {debit_T:.6f}')
from PIL import Image
im = Image.open(out / 'bull_call_spread.png')
assert im.mode == 'RGBA' and im.getextrema()[3][0] == 0
print('Transparent PNG verified:', im.size)
