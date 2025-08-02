# 🚀 Asteroid Impact Risk Predictor with Graph Neural Networks

This project uses Graph Neural Networks (GNNs) to predict potential asteroid threats to Earth by analyzing real orbital and physical data from NASA's CNEOS.

## 🔧 Components

- `models/gnn_model.py`: GCN-based neural net
- `utils/preprocess_data.py`: Loads and builds asteroid graph
- `train.py`: Trains the GNN to predict risk scores
- `utils/visualize_3d.py`: Plots asteroids in 3D risk space

## 📊 Dataset

- NASA CNEOS Close Approach data  
- Features used: CA distance, velocity, diameter, magnitude, rarity

## ⚙️ Run

```bash
python train.py
