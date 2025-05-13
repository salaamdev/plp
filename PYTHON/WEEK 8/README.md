# COVID-19 Global Data Tracker

## Project Description
This project is a comprehensive data analysis and visualization notebook that tracks global COVID-19 trends across different countries and time periods. The analysis examines cases, deaths, recoveries, and other key metrics to provide insights into the pandemic's impact worldwide.

## Project Objectives
- Import and clean COVID-19 global data from reliable sources
- Analyze time trends of cases, deaths, and recoveries
- Compare metrics across different countries and regions
- Visualize trends with informative charts and maps
- Communicate findings through a well-documented Jupyter Notebook

## Tools and Libraries Used
- **Python 3**: Core programming language
- **Jupyter Notebook**: Interactive computing environment
- **Pandas**: Data manipulation and analysis
- **NumPy**: Numerical computing
- **Matplotlib**: Data visualization (line charts, bar charts)
- **Seaborn**: Enhanced data visualization
- **Plotly Express**: Interactive and geographical visualizations (choropleth maps)
- **Datetime**: Date handling

## Dataset
The analysis uses COVID-19 data from the following files:
- `country_wise_latest.csv`: Latest country-level statistics
- `day_wise.csv`: Global daily statistics
- Other supplementary datasets in the COVID-19 Dataset folder

## How to Run/View the Project
1. Ensure you have Python installed with all required dependencies (listed in `requirements.txt`)
2. You can install all dependencies using: `pip install -r requirements.txt`
3. Open the Jupyter Notebook (`COVID19_Global_Data_Tracker.ipynb`) using Jupyter Notebook or VS Code
4. Run all cells sequentially to reproduce the analysis
5. Internet connection is required for the choropleth map visualizations

## Key Insights
- The data shows clear patterns in the global spread of COVID-19 over time
- Different countries exhibit varying case fatality rates, which may reflect differences in healthcare systems, demographics, or reporting methods
- The pattern of daily new cases reveals distinct waves of infection across the global pandemic timeline
- Some countries maintained better recovery rates than others throughout the pandemic period
- The visualizations effectively demonstrate both the scale and geographical spread of the pandemic

## Future Improvements
- Include more recent data as it becomes available
- Add vaccination data analysis
- Investigate correlations with factors like population density and healthcare capacity
- Build predictive models to forecast future trends
