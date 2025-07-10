**<h1>🛒 Walmart Sales Analysis</h1>**

This project analyzes Walmart store sales data using PostgreSQL for database operations and Python for data manipulation and visualization. It explores trends, patterns, and performance across multiple dimensions such as stores, departments, and seasonal events.

**<h3>📦 Dataset Overview</h3>**

The data originates from Walmart's internal sales reports and includes:
- Store-level weekly sales
- Holiday impact
- Temperature and fuel price metrics
- Consumer Price Index and Unemployment rates

**<h3>🛠️ Technologies Used</h3>**

- Python: Data wrangling, analysis
- Libraries: pandas,sqlalchemy, psycopg2
- PostgreSQL: SQL queries and database management
- Notebook: Interactive data exploration
- pgAdmin: Database GUI management
- GitHub: Version control and project documentation

**<h3>🔗 PostgreSQL Connection</h3>**

Connection established via SQLAlchemy:
from sqlalchemy import create_engine

engine = create_engine('postgresql://username:password@localhost:5432/walmart')


**<h3>📊 Key Insights</h3>**

- Identified store-wise sales performance and peak seasons
- Correlated external factors like temperature and holidays with sales trends
- Detected anomalies and irregularities across departments
- Forecasted seasonal demand using statistical modeling

**<h3>📁 Project Structure</h3>**

project_walmart/
│

├── walmart_data/          # Raw CSV files

├── notebooks/             # notebooks

├── queries/               # SQL scripts

├── visualizations/        # PNGs and charts

├── README.md              # This file

└── requirements.txt       # Python dependencies


**<h3>🚀 Getting Started</h3>**

- Clone the repository:
git clone https://github.com/sonalipatil2911/walmart_data_analysis/project_walmart.git

- Set up your virtual environment:
python -m venv my_env
source my_env/bin/activate  # or .\my_env\Scripts\activate on Windows

- Install dependencies:
pip install -r requirements.txt

- Update your PostgreSQL credentials in the connection string.

- Run notebooks and explore insights!


**<h3>🤝 Contributing</h3>**
Feel free to fork the repo, submit pull requests, or raise issues for improvements and feedback!

**<h3>📜 License</h3>**

This project is licensed under the MIT License.
