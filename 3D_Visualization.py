from utils.visualize_3d import plot_asteroids_3d_with_wave

csv_path = "d:/Asteroid_Risk_GNN/data/neo_close_approaches.csv"
risk_scores_path = "d:/Asteroid_Risk_GNN/risk_scores.pt"

if __name__ == "__main__":
    plot_asteroids_3d_with_wave(csv_path, risk_scores_path)
f