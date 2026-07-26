# Olist Marketplace: Revenue, Customer & Operational Analysis

## Table of Contents

- [Project Background](#project-background)
- [Skills Demonstrated](#skills-demonstrated)
- [Dataset Structure](#dataset-structure)
- [Data Limitations & Analytical Considerations](#data-limitations--analytical-considerations)
- [Executive Summary](#executive-summary)
- [Sales Trends](#sales-trends)
- [Product Performance](#product-performance)
- [Regional Comparisons](#regional-comparisons)
- [Delivery Performance](#delivery-performance)
- [Customer Experience](#customer-experience)
- [Seller Marketplace Health](#seller-marketplace-health)
- [Recommendations](#recommendations)

## Project Background

Olist is a Brazilian e-commerce marketplace founded in 2015, connecting retailers with customers through a central digital platform.
The platform provides sellers with tools for order management, logistics, payments and customer support.

This analysis investigates Olist’s 2016-2018 marketplace data to identify key drivers of revenue growth, customer behaviour patterns, seller performance and operational challenges to provide recomendations that can improve revenue growth, operational efficiency and customer retention.


## Skills Demonstrated

- SQL data extraction and transformation
- Exploratory data analysis
- Business KPI development
- Customer behaviour analysis
- Revenue and sales trend analysis
- Operational performance analysis
- Power BI dashboard development
- Data storytelling and recommendations

## Dataset Structure

The Olist dataset consists of 9 relational tables containing information on:

- Customers
- Orders
- Products
- Sellers
- Payments
- Reviews
- Geolocation data

The dataset contains over 120,000 records across multiple marketplace processes, allowing analysis of revenue, customer behaviour, product performance and operational efficiency.

## Data Limitations & Analytical Considerations

The following limitations should be considered when interpreting the findings:
- **Limited historical period:** The analysis focuses on marketplace data from 2016-2018. While this provides insight into early marketplace growth, trends may not fully represent current customer behaviour or marketplace performance.
- **Incomplete early data:** Transaction activity in 2016 is limited, with only partial monthly records available. These periods were excluded from month-on-month growth calculations to avoid misleading growth rates caused by incomplete data.
- **Incomplete late-period data:** September and December 2018 contain limited transactional activity compared with other months and were excluded from trend comparisons where appropriate.
- **Product performance analysis:** Products without categories were excluded from category-level analysis, which may slightly impact category revenue and order concentration calculations.
- **Delivery performance analysis:** Delivery metrics are based on completed orders with available delivery timestamps. Orders with missing delivery information were excluded from delivery performance calculations.
- **Customer review analysis:** Review scores represent customers who submitted reviews and may not capture the experience of customers who chose not to leave feedback.
- **Revenue analysis:** Revenue calculations are based on product price values and do not include additional marketplace costs such as seller fees, logistics costs, marketing expenditure or operational expenses. Therefore, revenue concentration does not directly represent profitability.



## Executive Summary


Between Jannuary 2017 and ugust 2018, Olist experienced significant revenue growth, with revenue increasing by an average of 14.2% month-on-month before stabilising in 2018. The company’s reach also grew, with order volume increasing 15.7% monthly on average. Average order value (AOV) slightly declined, with an average of -0.6% per month, suggesting marketplace growth was driven more by an increase in transaction volume than an increase in spending amount. 

The following sections explore the key factors driving these trends and identify opportunities for improvement.

Below is the overview page from PowerBI dashboard and more examples are included throughout the report. The entire interactive dashboard can be found here



## Sales Trends

- **Revenue steadily increased throughout 2017**, reaching its peak of **£1.01M** in November 2017, suggesting overall strong marketplace growth. The company’s growth followed a similar trend, with a month-on-month **revenue growth rate of +52%** in November, likely reflecting Black Friday and seasonal holiday spending.
- **December 2017 sees its first decrease in revenue** in the second half of 2017, which is expected after November’s unusually high sales rather than evidence of slowing marketplace demand.
- Throughout 2018, **revenue and growth levels stabilise**, with revenue fluctuating between **£844K and £997K** and month-on-month growth ranging from **-13.2% to +27.7%**, suggesting the marketplace matured and stabilised after its rapid growth in 2017.
- **Average order value generally declined during revenue growth**. Feb 2017, May 2017, and Nov 2017 all saw periods of revenue growth of **+105.6%, +40.6% and +52.1%** respectively, however **AOV rates saw a decrease**, down **6.4%, 8.1% and 6.8%** respectively, suggesting that revenue growth was driven primarily by an increase in order volume than customer spending per order.

**Key takeaway**: Marketplace growth has been driven primarily by increasing transaction volume rather than higher customer spending.






## Product Performance


- Customer demand is concentrated among a small number of product categories - **26% of the company’s orders are from just three product categories**: Bed Bath Table, Health Beauty and Sports Leisure. These three product categories accounted for nearly **£3.3M in revenue** over the two-year period, **24% of the company’s total.**
- The **ten most ordered product categories account for over 63% of all products sold** and culminate in a combined **revenue of nearly £8.2M**, contributing over **60% of the company’s total revenue**.
- While Bed Bath Table and Health Beauty drive marketplace volume, higher-value categories such as Computers (**£1,098 average selling price**) generate revenue through premium transactions rather than order frequency.
- At the other end of the marketplace, categories such as Security & Services, Fashion Children's Clothes and CDs/DVDs/Musicals contribute negligible amounts to marketplace revenue, each **less than 0.01% of total revenue**. Order values also contribute to around **0.01% of all products sold on the marketplace**, showing do they not only have a low overall revenue impact but they also have limited customer demand.

**Key takeaway:** Revenue is concentrated among a relatively small number of product categories, creating clear priorities for inventory and marketing investment.



## Regional Comparisons

- The three states with the largest revenue share are São Paulo, Rio de Janeiro and Minas Gerais, contributing **£5.2M (38.2%), £1.8M (13.4%) and £1.6M (11.7%)** respectively. 
- States SP, RJ and MG also currently represent the largest share of operational work, generating **41.98%, 12.92% and 11.70% of all marketplace orders** respectively, together contributing a **total of 66.60% of marketplace orders**. Order volume closely mirrors revenue ranking, suggesting differences in revenue are driven primarily by customer demand than significantly higher customer spending. 
- Paraíba, a state located in the northeast of Brazil, has the highest AOV of the marketplace, with customers spending **£216.67 per order** across a total of 532 orders. This is significantly higher than larger markets such as São Paulo, with an AOV of £125.70 per order. 


**Key takeaway:** Demand is heavily concentrated in three states, making operational improvements in these regions likely to have the greatest business impact.






## Delivery Performance


- **The average delivery time across the marketplace is 12.5 days**, however the **median delivery time is 10 days**, meaning half of customers receive their order within 10 days.
- The 90th percentile shows that the **slowest 10% of deliveries take approximately 25 days or longer**, with the longest delivery taking significantly longer, suggesting the average delivery time is slightly increased by a smaller number of delayed deliveries. The median provides a more accurate representation of the typical customer experience.
- From 99,441 total orders on the marketplace, **89.15% were delivered early, 1.30% were delivered on-time, and 6.57% of orders were delayed** and delivered later than their expected delivery time.
- States MA, CE, BA and RJ experience **delay rates of 16.73%, 13.17%, 11.72% and 11.63%** of their total orders respectively. However, RJ is particularly important due to its high order volume, meaning its delays may affect a larger number of customers compared with lower-volume states.
- São Paulo (SP) to São Paulo (SP) represents the largest source of delayed deliveries, with 1,428 delayed orders, accounting for **21.85% of all marketplace delays**. Although the delay rate on this route is relatively low at 4.53%, the high number of delayed orders is driven by the significant order volume between these locations. 
- Other high-volume routes, particularly SP - RJ and SP - MG, also contribute significantly to marketplace delays. These routes experience delay rates of **13.62% and 5.19%** respectively, contributing 17.63% and 6.03% of all delayed orders.


**Key takeaway:** Although the highest delay rates occur in several lower-volume states, the greatest operational impact is concentrated on high-volume routes serving São Paulo, Rio de Janeiro and Minas Gerais. 

Reducing delays on these routes is likely to deliver a greater overall improvement in marketplace performance and customer satisfaction than focusing solely on regions with the highest percentage of delays.


## Customer Experience

- **Early and on-time deliveries have average review scores of 4.29/5 and 4.03/5** respectively, whereas **delayed deliveries have an average review score of 2.27/5**, almost 2 points lower than early deliveries (4.29/5).
- 11,365 of the 98,673 reviews have a score of 1/5, totalling **11.52% of all customer reviews**. 3,432 late deliveries have 1-star reviews from a total of 6,535 delayed deliveries, equating to **52.52%**. Delayed deliveries received a 1-star review rate approximately **4.6 times higher than expected**, indicating a strong association between delayed delivery and poor customer ratings.

**Key takeaway:** Delivery reliability has a substantial influence on customer satisfaction, with delayed orders being far more likely to receive 1-star reviews.



## Seller Marketplace Health


- The three largest sellers completed 1,854, 1,806 and 1,706 orders respectively, totalling **5.40% of total orders** on the marketplace, suggesting a marketplace with sales distributed across many sales as opposed to being dominated by a small number of sellers.
- The ten sellers generate the highest revenue to the marketplace together contribute to **13.15% of the overall marketplace revenue**. Revenue is not heavily concentrated among a few sellers, suggesting the marketplace has a relatively balanced revenue distribution and is less vulnerable to losing a single major revenue provider.
- The **average review score across the marketplace is 4.09/5**. The top 10% of sellers by revenue have an average review score of 4.02/5, which is slightly below the marketplace average

**Key takeaway:** Overall, seller activity and revenue are well distributed across the marketplace, reducing concentration risk while maintaining healthy competition. Slightly lower review scores among the highest-revenue sellers suggest that the scale of an individual’s operation does not necessarily translate into a better customer experience.




## Recommendations

Based on the analysis, five key opportunities were identified:

**1. Optimise high-volume delivery routes**

Prioritise logistics improvements across São Paulo, Rio de Janeiro and Minas Gerais, where 66.6% of marketplace orders are generated. Reducing delays in these regions would create the largest customer impact.

**2. Improve delivery reliability**

Delayed deliveries are strongly associated with lower customer satisfaction, with delayed orders receiving an average review score of 2.27/5 compared with 4.29/5 for early deliveries. Improving delivery performance should be a priority for retention.

**3. Invest in high-performing product categories**

Focus inventory, seller acquisition and marketing resources on the top-performing categories, which contribute over 60% of marketplace revenue.

**4. Target high-value customer regions**

Analyse high-AOV states such as Paraíba to identify customer segments with higher spending potential and develop targeted marketing strategies.

**5. Support seller performance**

Maintain seller diversification while improving operational performance among high-volume sellers through delivery and customer satisfaction monitoring.
