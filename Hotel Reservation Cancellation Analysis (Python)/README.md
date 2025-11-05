# 🏨 *Hotel Reservation Cancellation Analysis*

---

## ✳️ *Overview*
This project focuses on performing a **root-cause analysis** of hotel booking cancellations using **Python** in Jupyter Notebook.  
By leveraging analytical and visualization libraries, the study identifies **behavioral patterns** and **key drivers** behind high cancellation rates, supporting data-driven improvements in hotel management and customer retention strategies.

---

## ✳️ *Objectives*
* Clean and prepare the raw hotel reservation dataset for accurate analysis  
* Explore booking trends and cancellation behaviors  
* Identify major factors contributing to cancellations  
* Provide insights to help reduce cancellation rates and improve booking policies  

---

## ✳️ *Tools & Libraries*
| Tool / Library | Purpose |
|----------------|----------|
| **Python** | Main programming language |
| **Pandas** | Data cleaning, preprocessing, and analysis |
| **NumPy** | Numerical operations and data transformation |
| **Matplotlib** | Data visualization (bar charts, line plots, heatmaps) |
| **Jupyter Notebook** | Interactive analysis environment |

---

## ✳️ *Data Preparation & Cleaning*
* Loaded raw hotel booking data into a Pandas DataFrame  
* Removed null and duplicate records  
* Encoded categorical variables (e.g., customer type, deposit type)  
* Standardized date and numerical formats  
* Created new derived features such as **cancellation ratio** and **average lead time**

---

## ✳️ *Exploratory Data Analysis (EDA)*
Key analyses performed:

* **Booking Patterns:** Trends by month, customer segment, and market type  
* **Lead Time Impact:** Longer lead times correlated with higher cancellation probability  
* **Deposit Type Effect:** Non-refundable deposits significantly reduce cancellations  
* **Country & Customer Type:** Certain regions and customer types showed higher cancellation behavior  

---

## ✳️ *Visual Insights*
* Used **Matplotlib** to visualize:
  * Cancellation distribution by month  
  * Average daily rate comparison between canceled and non-canceled bookings  
  * Correlation heatmap of key numerical features  
  * Top 10 countries with highest cancellation rates  
