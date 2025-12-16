import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score

# 1. Load the data engineered in SQL
df = pd.read_csv('customer_features.csv')

# 2. Define Features (X) and Target (y)
# Assuming you have historical data where you know who actually churned (0 or 1)
X = df[['purchase_frequency', 'inactivity_days', 'complaint_count', 'total_spend']]
y = df['actual_churn_status'] 

# 3. Train Model
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
model = RandomForestClassifier(n_estimators=100)
model.fit(X_train, y_train)

# 4. Compare AI vs Rule-Based
y_pred_ai = model.predict(X_test)

# Calculate Accuracy
ai_accuracy = accuracy_score(y_test, y_pred_ai)
print(f"AI Model Accuracy: {ai_accuracy * 100:.2f}%")

# This creates the narrative: 
# "Rule-based SQL approach was 60% accurate. AI Random Forest was 85% accurate.
# Therefore, ~25% improvement."