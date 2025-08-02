import pandas as pd
import numpy as np
import torch
from sklearn.preprocessing import StandardScaler
from scipy.spatial.distance import cdist

def load_cneos_close_approaches(file_path):
    df = pd.read_csv(file_path)

    # === Clean "Diameter" Column (e.g. "33 m - 75 m") ===
    def parse_diameter(d):
        try:
            parts = d.split(' - ')
            min_d = float(parts[0].split()[0])
            max_d = float(parts[1].split()[0])
            return (min_d + max_d) / 2
        except:
            return np.nan

    df['diameter_avg'] = df['Diameter'].apply(parse_diameter)

    # === Feature Selection ===
    features = ['CA DistanceNominal (au)', 'V relative(km/s)', 'H(mag)', 'diameter_avg', 'Rarity']
    df = df.dropna(subset=features)

    X = df[features].values

    # === Normalize Features ===
    scaler = StandardScaler()
    X_scaled = scaler.fit_transform(X)

    # === Build Adjacency Matrix (based on similarity) ===
    dist_matrix = cdist(X_scaled, X_scaled)
    threshold = np.percentile(dist_matrix, 5)  # connect top 5% closest
    adj = (dist_matrix < threshold).astype(int)
    np.fill_diagonal(adj, 0)

    # === Use 'Rarity' as proxy for impact risk (normalized) ===
    y = df['Rarity'].astype(float).values / 3.0  # normalized to [0, 1]

    return torch.tensor(X_scaled, dtype=torch.float32), torch.tensor(adj, dtype=torch.float32), torch.tensor(y, dtype=torch.float32)
