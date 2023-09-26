# GlobalPopulationTrends

## Project Description
This project focuses on population trends for each country in the world, with data ranging from 2017 through 2021. For this project, I'm going to act as a data analyst for an imaginary company working to
expand global operations. I want to focus on which countries are gaining and losing population, as well as countries becoming more developed as a result of certain trends. This project was cleaned and
analyzed using MySQL and visualized using Tableau. Attached with this README are the raw dataset I downloaded, the queries I used to clean the data, the queries I used for analysis, as well as the
dashboard I created to represent my findings appropriately.

## Dataset Source
The data obtained for this project was obtained from [https://www.kaggle.com/datasets/alitaqi000/global-population-trends2016-2022] by Syed Ali Taqi. The data was scraped from [https://www.macrotrends.net/countries/topic-overview].
All credit for scraping, obtaining, and sharing the data goes to Syed Ali Taqi.

## Original Dataset Description
![Screenshot 2023-09-25 154352](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/e45b1bbf-a483-4d90-b416-469935e87b27)
For each country, data will be provided for each year between 2018 and 2021. For almost all these countries, data for 2017 is also provided. It is worth noting that in several entries, data is not provided
for some or even most of the entries. There are 12 columns associated with this dataset:
* Country: The name of the country. Each country is recorded five times each, once for each year between 2017 and 2021. If a country does not have 2017 data available, it will appear four times.
* Year: A year between 2017 and 2021. The data is sorted by country from A to Z, then by year ascending. Each combination of country and year data represents a primary key. In other words, no two entries will have the same country AND year.
* Total Population: The total population of the country
* Urban Population: The urban population of the country
* Rural Population: The rural population of the country
* Population Density: The country's mid-year population divided by the land area in square kilometers
* Life Expectancy: The average life expectancy for an infant with current trends
* Birth Rate: The number of births occurring during the year per 1,000 people
* Death Rate: The number of deaths occurring during the year per 1,000 people
* Fertility Rate: The average number of children a woman would give birth to during her lifetime
* Infant Mortality Rate: The number of infants dying before being one year old per 1,000 people
* Growth Rate: A number on a scale of -5 to 5, with 5 representing extreme growth, -5 representing an extreme population decrease, and 0 indicating little population change

## Problems
1. Which countries seem to be growing the most? What about countries that are losing the most population?
2. Are more people moving to urban areas or rural areas? Are any areas experiencing high urbanization (more than 8% of people are moving to urban areas)?
3. How has the life expectancy changed?
4. Which countries are growing the most in regards to births compared to deaths?
5. Which countries are growing the most in regards to fertility rate compared to infant mortality rate? 

## Data Cleaning
The first thing I checked was to make sure that there were no duplicates. To do so, I checked the length of the dataset, 1,030 entries, and selected entries which had no duplicates containing the same
combination of a country and a year. Doing so, I verified that the length was also 1,030, indicating there were no duplicates in the data.

From there, I checked the values of each column to make sure they were reasonable. One thing that caught my attention was seeing that there were some countries which had a birth rate of 0.
![Screenshot 2023-09-25 162532](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/20e02be3-b2b2-4a7b-bc29-0061a6cf977c)

These countries also have a death rate of 0. Considering the next lowest birth rate is 5, and the next lowest death rate is 0.982, the likelihood the data here is actually 0 as opposed to being unknown
is unlikely. As such, I replaced all the birth rate entries that were initially 0 to null. I did the same thing with death rate entries.

I noticed a similar issue occur regarding fertility rate. For four of the five years, it was estimated that Palau's fertility rate was 0, but in the one year data was recorded, this fertility rate was
actually 0.8.
![Screenshot 2023-09-25 162617](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/19de0cc3-b65c-4558-8eba-dabb530c81d9)

Noticing this, I also set the fertility rate to null if it was equal to 0.

From here, we were ready to move onto the next step of the project: creating queries that we can use to start our analysis.

## Analysis
Each of my queries were made using a variety of averages, subqueries, case expressions, and joins. Again, each of the queries I made for the purposes of analysis is available in the SQL file.

The only major thing I had noticed during analysis was that there were many years where all the other years would have the data appropriately recorded whereas one particular year wouldn't. For instance,
I observed that many countries didn't have 2017 total population recorded. A lot of the analysis focused on rates, and so for each part of my analysis, I compared the earliest available year with data to
the latest available year with data. This means that for several of my findings, the years that I considered were not necessarily the same. For the population growth, urban population, births, and deaths,
I used 2018-2021 as my general timeframe. For life expectancy, I used 2017-2020 as my timeframe. Fertility and infant fatality were the only two demographics I had measured that had available data for
each year between 2017 and 2021.

## Dashboard Description and Takeaways
**Show the visuals for each aspect of the dashboard, and what we can takeaway from the visuals**
![Screenshot (6)](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/5d4c79c3-0fcd-42c7-8ec6-2bdcdb3ff5df)
This map show how populations have changed between 2018 and 2021. As an important note, this focuses on percentage growth rather than number of people. The more blue a country is, the more the population
has grown, and the more orange a nation is, the more of a population it has lost. Overall, we can observe that global population is growing. However, if we dive a bit deeper, we see there are three regions
in particular which are experiencing population booms: Sub-Saharan Africa, the Middle East, and central Asia. On the other hand, we see that eastern Europe has been losing population overall. However,
there are also a few outliers that are also experiencing population loss, including Japan, Oman, and notably, Venezuela. We will want to explore these areas as we continue to see if any patterns occur, and
a good place to start may be comparing how growth rates compare with urbanization rates.

![Screenshot (7)](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/84005812-57be-45e9-ac37-e60d4717563d)
This map shows the percentage of people in each country moving to urban centers, with blue countries showing an increase in urbanization and orange countries showing a decrease in urbanization. Immediately,
we observe that there's a positive correlation between population growth and urbanization. In other words, if a nation's population increases, it's likely that its urban population will also increase. We
can also identify these trends by region as well. Similarly, we observe lots of people moving to urban centers in Sub-Saharan Africa and areas of the Middle East. Before we look specifically into areas
with high urbanization, it's worth mentioning that Eastern Europe also has decreasing urbanization rates, which makes the correlation consistent. However, it's also important to note that nations with
decreasing population rates are not losing urban population quite as drastically.

![Screenshot (11)](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/6c1b8cc3-f94c-4908-a426-c73d3553de64)
This shows countries that are experiencing high urbanization. In other words, more than 8% of the population has moved from the rural areas to the urban centers. Almost the entirety of Sub-Saharan Africa
is experiencing high urbanization. However, other general areas to note are the Middle East, central Asia, and southeast Asia. However, for each of these Asian areas, the urbanization growth is certainly
not as strong as it is in Sub-Saharan Africa.

![Screenshot (8)](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/ad2018ae-e50f-4462-b134-edb4080de140)
This map shows life expectancy changes in each nation, with orange nations having a lower life expectancy in 2020 compared to 2017, and blue nations having a higher life expectancy. Most countries seem to
be either maintaining a consistent life expectancy or experiencing decreases in life expectancy. Again, if we look at Sub-Saharan Africa, while it's true that there are some nations in the region where life
expectancy is decreasing, there seems to be a significant region where population is either the same or increasing. With the exception of Niger and Botswana, every country from Chad and Sudan downwards either
has no life expectancy change or an increase in life expectancy, which counters the overall trend we see. We also observe a general increase in life expectancy in east Asia.

![Screenshot (12)](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/f8d060c6-66cf-4b2e-8df7-7ad329c7e2e9)
This map shows each country's births compared to its deaths. Countries that are more blue will have more births for every one death. However, countries that are more orange will have less births for every
one death. While Sub-Saharan Africa is still a solid blue area, with several countries being deep blue, there is an area to note that has significantly more births compared to deaths: the overall Middle
East. Each country in the Middle East is a deep shade of blue, indicating that with current trends, each of those nations will have populations that drastically increase. Overall, with the exception of
Europe, there seem to be more people that are born compared to those that die, which is the big reason why our global population as a whole is increasing.

![Screenshot (10)](https://github.com/stberr19/GlobalPopulationTrends/assets/144372443/f9224073-1d04-4e26-a903-3c8a0669204e)
This map shows how each country's fertility rate compares to its infant mortality rate. Because fertility rates are per woman and because infant mortality rates are per 1,000 people, I made a customized formula
that would take the infant mortality rate, divide it by 1000, and then subtract that value from the fertility rate. This would show an overall trend where bluer countries have high fertility rates and
low infant mortality rates. This would be a major factor in determining which countries are developing countries. Again, the important region to take note of is Sub-Saharan Africa. With fertility rates
being high and infant mortality rates being low in these regions, it makes a lot of sense why these nations are booming in population.

## Conclusions and Business Suggestions
From the trends that we observed, we are able to answer each of the questions we initially had.
* Global population is generally increasing, with countries in Sub-Saharan Africa, the Middle East, and Central Asia growing the most, while countries in Eastern Europe are losing population.
* More people are moving to urban areas, with Sub-Saharan Africa, the Middle East, Central Asia, and Southeast Asia experiencing high urbanization.
* Life expectancy is decreasing worldwide, but Sub-Saharan Africa and Eastern Asia defy this trend.
* More births tend to happen than deaths, with this trend being strongest in the Middle East and Sub-Saharan Africa.
* Fertility rates exceed infant mortality rates, particularly in Sub-Saharan Africa and central Asia.

Looking at these trends, there are four regions that have shown up multiple times in our observations: Sub-Saharan Africa, the Middle East, Central Asia, and Southeast Asia. These nations show the most
promise in terms of where it would be best to expand international operations in the long-term future. However, it's important to also consider international relations with the U.S. For instance, even
though Afghanistan had been a recurring country with positive trends in our analysis, it would certainly be a poor decision for an American business to have an office there after 20 years of war.

A good solution would be to open up three international offices, with one being in Lagos, Nigeria, one being in Dubai, United Arab Emirates, and one being in Bangkok, Thailand, with Lagos and Bangkok
serving as strong business hubs for Sub-Saharan Africa and Southeast Asia, respectively, and Dubai being a good hub to service both the Middle East and Central Asia. If the business is looking to open
up an international office in the western world, a good choice might be Dublin, Ireland because Ireland consistently defies trends that the rest of Europe displays.
