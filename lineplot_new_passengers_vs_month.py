import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
df_trips = pd.read_csv('C://Users//chitl//Downloads//RPC13_Input_For_Participants (1)//RPC13_Input_For_Participants//datasets//csv_files//fact_trips.csv')
df_passenger_summary = pd.read_csv('C://Users//chitl//Downloads//RPC13_Input_For_Participants (1)//RPC13_Input_For_Participants//datasets//csv_files//fact_passenger_summary.csv')
df_ratings = pd.read_csv('C://Users//chitl//Downloads//RPC13_Input_For_Participants (1)//RPC13_Input_For_Participants//datasets//csv_files////city_target_passenger_rating.csv')
df_new_passengers = pd.read_csv('C://Users//chitl//Downloads//RPC13_Input_For_Participants (1)//RPC13_Input_For_Participants//datasets//csv_files////monthly_target_new_passengers.csv')
plt.figure(figsize=(8,5))
sns.histplot(df_ratings['target_avg_passenger_rating'], bins=20, color='seagreen')
plt.title("Passenger Ratings Distribution")
plt.xlabel("Average Rating")
plt.ylabel("Frequency")
plt.show()
