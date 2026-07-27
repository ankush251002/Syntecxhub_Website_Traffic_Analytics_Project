import pandas as pd
from sqlalchemy import create_engine

# 1. Load your dataset (change filename if yours is .csv or .xlsx)
df = pd.read_csv("D:\Project\Syntecxhub_Project\Task 2\data-export (1).csv", header=1)

# Clean column names slightly so SQL handles them easily (replaces spaces with underscores)
df.columns = df.columns.str.strip().str.replace(" ", "_").str.lower()

# 2. Connect to your local MySQL
# Replace 'your_password' with your actual MySQL Workbench root password
db_url = "mysql+pymysql://root:ankush8839@localhost:3306/website_traffic_db"
engine = create_engine(db_url)

# 3. Create the database table and load all 3k rows instantly
df.to_sql("traffic_data", con=engine, if_exists="replace", index=False)

print(" Done! All rows imported into MySQL Workbench.")