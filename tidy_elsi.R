# nces years
nces_years <- paste0(1986:2019, "-", substr(1987:2020, 3,4)) 


# define function to import nces data
import_nces_data <- function(csv_name, nces_label1, values){ # deleted nces_label2
  
  
  data <- read_csv(csv_name, skip = 6)
  
  # fix ids
  data <- data %>%
    mutate_at(vars(contains("ID"), contains("Code"), 
                   contains("Percent"), contains("Student"), contains("County")), 
              function(x) str_remove_all(x, '=|"'))
  
  
  # fix column names
  data <- data %>%
    rename_all(~ tolower(gsub(nces_label1, 
                              "", .x, fixed = TRUE))) %>%
    rename_all(~ tolower(gsub("..public.school..latest.available.year", 
                              "", .x, fixed = TRUE)))
  
  
  # pivot longer so that years are a single column var
  data_long <- data %>%
    pivot_longer(cols = any_of(nces_years),
                 names_to = "school_year",  values_to = "value")
  
  # turn addl chars into NAs
  data_long <- data_long %>%
    mutate_at(vars(value), na_if, "???") %>%
    mutate_at(vars(value), na_if, "-") %>%
    mutate_at(vars(value), na_if, "???")
  
  
  # add year variable
  data_long <- data_long %>%
    mutate(year = str_sub(school_year, 1, 4),
           variable = paste0(values))
  
  # drop rows with no id var
  data_long <- data_long %>%
    filter(!is.na(select(., contains("school id"))))
  
  
  return(data_long)
}

# now create tables

elsi_table <- function(list){
  
  data_frame <- pmap_dfr(list, import_nces_data) %>%
    pivot_wider(names_from = "variable", values_from = "value")
  
  
}
