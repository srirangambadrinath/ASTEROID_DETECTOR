import torch
from torch_geometric.utils import dense_to_sparse
from torch_geometric.data import Data
from models.gnn_model import AsteroidRiskGNN
from utils.preprocess_data import load_cneos_close_approaches

# === 1. Load & preprocess data ===
X, adj, y = load_cneos_close_approaches("D:/Asteroid_Risk_GNN/data/neo_close_approaches.csv")
edge_index, _ = dense_to_sparse(adj)
data = Data(x=X, edge_index=edge_index)

# === 2. Setup device ===
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
print("Device:", device)

model = AsteroidRiskGNN(in_channels=X.shape[1], hidden_channels=32).to(device)
data = data.to(device)
y = y.to(device)

# === 3. Optimizer & Loss ===
optimizer = torch.optim.Adam(model.parameters(), lr=0.01)
loss_fn = torch.nn.MSELoss()

# === 4. Training Loop ===
print("\nStarting Training...\n")
for epoch in range(1, 31):
    model.train()
    optimizer.zero_grad()
    output = model(data.x, data.edge_index)
    loss = loss_fn(output, y)
    loss.backward()
    optimizer.step()
    print(f"Epoch {epoch:02d} | Loss: {loss.item():.6f}")

# === 5. Save output scores (optional) ===
torch.save(output.detach().cpu(), "risk_scores.pt")
print("\nTraining Complete. Risk scores saved as 'risk_scores.pt'")
