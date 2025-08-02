import pandas as pd
import numpy as np
import torch
import matplotlib.pyplot as plt
from mpl_toolkits.mplot3d import Axes3D

def clean_value(x):
    try:
        return float(str(x).split()[0])
    except:
        return np.nan

def plot_asteroids_3d_with_wave(csv_path, risk_scores_path):
    print("🚀 Starting asteroid visualization with wave plot...")
    print("📁 Loading dataset...")

    df = pd.read_csv(csv_path)
    print(f"✅ CSV Loaded: {df.shape}")
    print(f"📊 CSV Columns: {df.columns.tolist()}")

    risk_scores = torch.load(risk_scores_path).numpy()
    print(f"📈 Risk scores loaded: shape {risk_scores.shape}")

    # Ensure sizes match
    if len(df) != len(risk_scores):
        print("⚠️ Warning: Mismatched sizes. Truncating to shortest.")
        min_len = min(len(df), len(risk_scores))
        df = df.iloc[:min_len]
        risk_scores = risk_scores[:min_len]

    # Parse required values
    x = df['CA DistanceNominal (au)'].apply(clean_value)
    y = df['V relative(km/s)'].apply(clean_value)
    z = df['Diameter'].apply(clean_value)

    # Normalize risk scores for color mapping
    risk_norm = (risk_scores - np.min(risk_scores)) / (np.max(risk_scores) - np.min(risk_scores))

    # --------- 🌌 3D ASTEROID SCATTER PLOT ---------
    fig1 = plt.figure(figsize=(10, 8))
    ax = fig1.add_subplot(111, projection='3d')
    fig1.patch.set_facecolor('black')
    ax.set_facecolor('black')
    
    # Scatter with colormap
    p = ax.scatter(x, y, z, c=risk_norm, cmap='plasma', s=60, alpha=0.95, edgecolors='white', linewidths=0.3)

    # Labels and title
    ax.set_title("🌌 Asteroid Risk in 3D Space", color='white', fontsize=14)
    ax.set_xlabel("Nominal CA Distance (AU)", color='white')
    ax.set_ylabel("Relative Velocity (km/s)", color='white')
    ax.set_zlabel("Diameter (m)", color='white')

    # Ticks
    ax.tick_params(colors='white')

    # Color bar
    cbar = fig1.colorbar(p, ax=ax, shrink=0.6, pad=0.1)
    cbar.set_label('Risk Score', color='white')
    cbar.ax.yaxis.set_tick_params(color='white')
    plt.setp(plt.getp(cbar.ax.axes, 'yticklabels'), color='white')

    # --------- 🌊 RISK-WEIGHTED SINE WAVE PLOT ---------
    fig2 = plt.figure(figsize=(9, 4))
    t = np.linspace(0, 2 * np.pi, len(risk_scores))
    wave = np.sin(t) * risk_scores

    plt.plot(t, wave, color='teal', linewidth=2)
    plt.title("🌊 Risk-Weighted Sine Wave")
    plt.xlabel("Time")
    plt.ylabel("Wave Value")
    plt.grid(True)

    plt.show()
