# Testing-Inverse-Cramer
## Introduction
Lately, an investing concept known as "Inverse Cramer" has been attracting attention. Its namesake, Jim Cramer, has been an investment analyst and host of the show "Mad Money" on CNBC for decades. The "Inverse Cramer" strategy even led to a fund that even purported to outperform the "Nancy Pelosi Husband Tracker" for a brief period of time. Put simply, the "Inverse Cramer" doctrine is: Whatever Cramer says, do the opposite! Consequently, I decided to look into whether the "Inverse Cramer" effect could really inform a viable trading or investing strategy. 

## Dataset
- **Source**: Data acquired from Kaggle, titled Jim Cramer's Picks 2016-2022 (https://www.kaggle.com/datasets/diamondprox/jimcramer). I also downloaded the most up to date version of current prices of S&P 500, also via Kaggle (https://www.kaggle.com/datasets/andrewmvd/sp-500-stocks)
- **Structure**: The Cramer data set lists every Buy, Sell, Hold, Negative Mention, and Positive Mention that Cramer made between 2016 and 2022 for public companies. The S&P 500 data set lists the most recent prices of S&P 500 companies, as well as tickers, sector, industry, and company name (I used the data from November 30, 2024 in this analysis). 
## Tools Used
- Python
- Excel
- SQL
- Power BI

## Methodology
**Data collection and preprocessing:**
   
First I loaded the two data sets into MySql Workbench. I inner joined these tables together on the ticker symbols, to effectively add current stock prices, sector, and industry onto the Cramer dataset, which was missing these values. This step also limited the analysis simply to S&P 500 companies, which was important to do because too many of the smaller companies in the data set had gone out of business or been delisted. Then I found that some companies in the Cramer dataset were listed as "Not Available", so I updated the missing values in this column with the company names from the S&P500 data. I then dropped the redundant columns, converted the Date column to correct format, and exported the new datatable as a csv file.

Second, I opened the data in an Excel worksheet and used the STOCKHISTORY function to find the price of each stock on the specific day Cramer recommended it. Originally I wrote code to do this in Python, but the Yahoofinance API wouldn't allow so many requests at one time. The STOCKHISTORY function found values for all but 153 rows out of about 12,000 rows, but I did notice a few instances in which the prices were in other currencies. For the 153 rows that Excel couldn't find data for, it inputted '#VALUE!' or '#N/A'. 

I then loaded the csv file into Jupyter Notebook as a pandas DataFrame. I first dropped two empty columns from the DataFrame, and formatted the '#VALUE!' and '#N/A' strings as np.nan values. I then attempted to iterate through these rows specifically, fetching data from Yahoofinance and inputing the 'Close' price on the date of Cramer's recommendation into the column "HistoricalPrice". I then calculated new columns "Time Since Recommendation" (in days), "Years Since Recommendation" (in yields), "Total Yield" (in %) and "Annual Yield" (in %). 

I then eliminated all rows in the DataFrame in which Annual Yield was more than 500%. Unfortunately it's not a perfect solution, but I think it will primarily eliminate the most egregious cases of errors caused by flawed data (what I believe mostly originates from incorrect currencies being used for historical stock prices in Excel's STOCKHISTORY function). In any case, the size of the data should ensure its robustness, but I will also prefer metrics that are more robust to skewness (median rather than mean, for example) in the analysis. 

With all that done, the dataset is cleaned and prepared with the information required for rigorous analysis and visualization, which I did in both Jupyter Notebook and Power BI. 

**Exploratory Analysis in Python:**

Overall, how did Cramer do? The boxplot below shows fairly consistent stock performance regardless of Cramer's call (with the caveat that there are many outliers in each category). Cramer's "Hold" recommendations seemed to do the best overall, although there are too few recommendations in this category to draw any solid conclusions. The screenshot shows the average returns of Cramer's calls grouped by the type of call (Buy, Sell, Hold, etc).

![download](https://github.com/user-attachments/assets/ab012dc0-616d-4395-934a-0e48c06bb73c)

![image](https://github.com/user-attachments/assets/c7c3f77b-41c9-4986-88e2-bf4f33190371)


Categorizing Cramer's picks by sector seems to uncover some important patterns. In the Tech sector, for example, his Buy calls certainly outperformed his sell calls, while the exact inverse is true in the Financial Services Sector. 

![download](https://github.com/user-attachments/assets/b9e11493-bf23-4ef5-974b-787af74220c1)

![download](https://github.com/user-attachments/assets/6e73554b-fa30-46bc-a295-5baf43c21107)

Like in the Financial Services Sector, Cramer's Buy picks in the Real Estate sector underperformed his Sell picks: 

![download](https://github.com/user-attachments/assets/c7623a1b-49ec-4916-9429-e9402f2dc66e)

So far this exploratory analysis suggests that investing Cramer's recommendations may require different heuristics depending on the sector in which the recommendation was made. For example, buying tech companies that Cramer was bullish on, and buying Financial companies that Cramer was bearish on, would have been a hugely lucrative investment strategy. 

**Further Analysis Using Power BI:**

We can see the vast majority of Cramer's recommendations are "Buy" recommendations: 

![image](https://github.com/user-attachments/assets/fb737e65-17db-4440-94b2-5c0cf642d068)
   
The plurality of Cramer's recommendations are in the Technology Sector, followed by Consumer Cyclical and Industrials. Cramer is least involved with Real Estate, Basic Materials, and Utilities. 

![image](https://github.com/user-attachments/assets/80ac3ae1-007a-4e4a-9339-edf08baebf7b)

Cramer's "Buy"s outperform his "Sell"s in Technology, Basic Materials, Communications Services, and Healthcare, while the inverse is true in Financial Services, Consumer Cyclical, Industrials, Energy, Utilities, Consumer Defensive, and Real Estate: 

![image](https://github.com/user-attachments/assets/aa8f8aff-c535-483a-990f-f498d352c484)


What have been Cramer's best and worst calls overall? The figures below show Cramer's best performing Buy and Sell recommendations. Cramer consistently recommended Nvidia over the years, which is his best performing "Buy" recommendation on average. His worst "Buy" suggestion was Este Lauder, which provided an annual yield of nearly -40% on average from the dates of Cramer's "Buy" suggestions for the stock. 

Cramer's sell recommendations on Targa Resources, Tesla, Builder FirstSource, and Vistra Energy were very bad suggestions in hindsight, as all of those stocks have outperformed all but one of Cramer's Buy picks. To be fair, some stocks like Tesla that Cramer has recommended selling at times, he's also recommended buying at other times.

![image](https://github.com/user-attachments/assets/bddd7596-6825-4a5d-8de3-cdf92bf8969b)

Does Cramer's performance show any dependence on the year of his recommendation? The figure below shows that following Cramer's sell suggestions in 2016 and 2020 would have been very bad for one's investment portfolio in the long run. On the other hand, following Cramer's "Buy" recommendations between 2016 and 2020 would have yielded good long-term results. His more recent record in 2021 and 2022 is not great. While the S&P has returned over 60% since the start of 2021 till present, Cramer's Buy picks in 2021 and 2022 would have only returned 7.3 and 7.5%, respectively. 

![image](https://github.com/user-attachments/assets/7c4cb3f9-0ae6-41db-88c3-43ab1511d6f2)


Finally, we can use our data to see how Cramer's picks do relative to the S&P 500 index after fixed intervals of time. After 1 year, Cramer's median pick (regardless of whether they're Buy or Sell) does about as well as the S&P 500 Index. 

![image](https://github.com/user-attachments/assets/1d860e86-7f99-4b6f-8058-419737569e38)

One month post-recommendation, Cramer's median pick in each category tends to underperform the S&P index: 

![image](https://github.com/user-attachments/assets/bd9ece22-43cd-4d2a-8f24-fc36d91ac0f6)

Interestingly, Cramer's recommendations tend to move much more than the S&P index in the one day period following his recommendation. This could be explained as a selection bias, since Cramer likely pays more attention to stocks that are volatile or newsworthy at the time of recording his show. Noteably, the stocks he recommends selling do the best on average in the following one day period, suggesting that there could be a tradeable "Cramer Effect" for these types of stocks. However, the average one day return is so tiny that it would not be a reliable trading mechanism. 


![image](https://github.com/user-attachments/assets/f61a696a-4409-4247-b082-3e33ae969281)


## Results

There are two big questions that arise from this analysis. First, what investment strategy can be gleaned from an analysis of Cramer's recommendations, and second, should the average investor pay any heed to what they hear from Cramer on CNBC?

In both cases the answer seems to be sector-dependent. If you were primarily invested in technology stocks, you would have done very well by strictly following Cramer's advice. Even though Cramer's Sell recommendations in the Tech sector outperformed his Buy recommendations in **every other sector** (with median annual return of 16% to date), his Buy suggestions in the tech sector did even better with a median annual return of 25% to date. Part of that is just due to the Tech sector's tailwinds over the last several years, but even so Cramer shows an ability to pick stocks well in this sector. 

In the Financial Services sector, on the other hand, Cramer's Sell recommendations outperformed both his Buy and Sell recommendations in **every other sector**, with a 27% median annual return. His Buy recommendations still did well in this sector, with a median return of about 16%. Like Tech, the financial industry has had a tailwind behind it due to higher interest rates worldwide, but unlike in Tech, Cramer does not seem capable of distinguishing between outperforming and underperforming financial companies. 

The only other sector in which Cramer's record is somewhat impressive is the Basic Materials sector. His Buy suggestions have recorded a 14% return whereas his Sell suggestions have only a 5.6% return. But only 3% of Cramer's total calls pertain to this sector, so this positive record may just be a result of luck rather than insight. Statistical fluctuations increase with smaller sample sizes, so kind of variation in sectors with fewer calls might be expected. 

Jim Cramer brands himself as a no-nonsense guru with deep knowledge of thousands of public companies along with expertise in financial analysis. Though there are limitations to the scope of possible data analysis given the data collected, the analysis so far does not paint a picture of either an expert or a novice. He seems to get a lot right and a lot wrong, and individual investors could do either very well or very poorly depending on what they happen to listen to. 

Inverting Cramer's picks also does not seem to be a viable long-term investment strategy. While it's true that in most sectors Cramer exhibits the tendencies of "Dumb Money" individual investors, it would also be a very bad strategy to short his Buy recommendations in the Tech sector, or most sectors for that matter. The only viable "Inverse Cramer" strategy apparent from the data is buying Cramer's Sell recommendations in the Financial Services sector. Before embarking on any investment strategy, further research would be necessary to evaluate the specifics of Cramer's calls in these individual sectors. 

The new "Cramer Rule" should be: Take it with a pinch of salt (with the possible exception of his Tech Sector Buy suggestions).
