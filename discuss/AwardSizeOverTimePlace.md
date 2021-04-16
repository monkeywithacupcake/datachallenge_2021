# Explore Award Size v Time and Place
*question*: What does contract data reveal about national interest internally? 
*status*: idea to consider
*proposed by*: Jess
*need other data*: yes

## Notes

Current analysis file: /analysis/award_size_place.R
Quick first look at this from 2017 to 2020 shows that there are apparently huge outliers (very large sized Award$ totals in one US Zip Area (first digit)). These outliers make the rest hard to distinguish.

![Award Size Place]("AwardSize v Year and Zip.png")

## Next Steps

1. Identify reason for outliers - possible causes thought of so far are: 
  - maybe there are large awards concentrated in time and place
  - the cleaning script to make award $ is dropping range text
  - there are repeated postings of same award
  
2. See if can match contract opportunities with contracts awarded
