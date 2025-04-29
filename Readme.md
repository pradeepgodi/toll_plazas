### Prerequisites
1. Install Jupyter from conda
2. Install pandas, selenium,beautiful soup and other libraries
3. Google API key is needed to fetch the lat and long of a given toll plaza.

### Execution order
1. First execute toll_plazas_list.ipyng which generates tool_plazas.csv file
2. Secondly execute toll_plaza_information.ipynb which will read tool_plazas.csv and generate toll_plaza_data.csv
3. toll_plaza_data.csv will be uploaded to the postgresql database under the table name "toll_plaza". Details about it 


### References
Info about toll is webscraped from the below two public websites
1. https://tis.nhai.gov.in/tollplazasataglance.aspx?language=en#   --> to get the list of all toll plazas in india
2. https://tis.nhai.gov.in/TollInformation.aspx?TollPlazaID={toll_plaza_id} --> to get the price and facilities available at a given toll plaza



