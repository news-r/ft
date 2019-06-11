<!-- README.md is generated from README.Rmd. Please edit that file -->



<!-- badges: start -->
[![Travis build status](https://travis-ci.org/news-r/ft.svg?branch=master)](https://travis-ci.org/news-r/ft)
[![AppVeyor build status](https://ci.appveyor.com/api/projects/status/github/news-r/ft?branch=master&svg=true)](https://ci.appveyor.com/project/news-r/ft)
<!-- badges: end -->

# ft

Brings the [FT](https://www.ft.com/) Search API to R.

## Installation

You can install the package from [GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("news-r/ft")
```


## Setup

Create a free account at [developer.ft.com](https://developer.ft.com) to create an API key.

```r
ft_key("xxXXxxXx")
```

Note that you can specify the `FT_API_KEY` key as an environment variable in your `.Renviron` for convenience.


## Example


```r
library(ft)

# search 2 pages of articles "banks"
banks <- ft_search("banks", pages = 2)

# search titles of articles on "debates" and not Trump
debates <- ft_search("debates -Trump", curations = "ARTICLES", aspects = "title")
class(debates)
#> [1] "tbl_df"     "tbl"        "data.frame"
unlist(debates$title)
#>   [1] "US tech CEOs join campaign for abortion access"                                
#>   [2] "Sweeping reform needed after Brexit, says French regulator"                    
#>   [3] "Saudi business feels ‘pain’ of the crown prince’s reforms"                     
#>   [4] "It’s easy to forget there is a living city beyond the alluring Paris of myth"  
#>   [5] "Instagram atheists need to drop the hokum"                                     
#>   [6] "South Africa’s rand set for worst week since October"                          
#>   [7] "True grit: playwright Lynn Nottage on finding gold in America’s rust belt"     
#>   [8] "Investors may rue demanding market value for nationalised utilities"           
#>   [9] "Netflix’s cash burn is painful viewing for investors"                          
#>  [10] "Boris Johnson’s no-deal problem"                                               
#>  [11] "Who’s up and who’s down in the EU top jobs race"                               
#>  [12] "Germany’s AKK rebuked over comments on internet campaigning"                   
#>  [13] "Centre-left slump renews pressure on Germany’s grand coalition"                
#>  [14] "Frank Bowling: the British-Guyanese artist on his 60-year transatlantic career"
#>  [15] "Can music help in the fight against climate change?"                           
#>  [16] "Maoism: A Global History — a long overdue account of a world-shaking movement" 
#>  [17] "Bankers bemoan Mifid’s high costs and unclear benefits"                        
#>  [18] "JPMorgan Chase drops Purdue Pharma as a client"                                
#>  [19] "The UK water industry is globally respected"                                   
#>  [20] "Can the EU solve its autocrat problem?"                                        
#>  [21] "From Russia, with love"                                                        
#>  [22] "Ministers urged to make new poverty measure official"                          
#>  [23] "Type set: the best new fashion books"                                          
#>  [24] "European elections 2019: viewpoints from a continent at a crossroads"          
#>  [25] "Rotterdam’s Opera Days festival brings opera to the people"                    
#>  [26] "Turkey’s ‘low’ FX reserves leave country vulnerable, Moody’s warns"            
#>  [27] "No, corporate tax avoidance is not legal"                                      
#>  [28] "Australia to import wheat for first time in a decade"                          
#>  [29] "Alice Rivlin, former Fed vice-chair, dies at 88"                               
#>  [30] "Jeanette Winterson’s 21st-century reimagining of Frankenstein"                 
#>  [31] "Mud-slinging in India’s marathon election stains the body politic"             
#>  [32] "Europe Talks: FT readers discuss the future of the EU"                         
#>  [33] "The humble hashtag is both rebel yell and corporate tool"                      
#>  [34] "Big pharma/cancer: the allure of a cure"                                       
#>  [35] "US jobs report fails to settle market debate"                                  
#>  [36] "FT Health: Focus on toddlers scores victory over obesity"                      
#>  [37] "A selection of the FT’s biggest stories and best reads every Friday"           
#>  [38] "European elections 2019: lead candidates debate EU’s future"                   
#>  [39] "Rory Stewart moves from prisons to international aid"                          
#>  [40] "Spain’s shattered right hands Sánchez victory"                                 
#>  [41] "Electric vehicles: smoke without fire"                                         
#>  [42] "Film-maker Linda Goode Bryant: ‘I want to be disoriented’"                     
#>  [43] "Why Nicola Sturgeon is hedging her bets on Scottish independence poll"         
#>  [44] "Tootsie — cross-dressing movie gets a magnetic musical makeover"               
#>  [45] "Spanish party leaders trade blows in second election debate"                   
#>  [46] "ECB hopefuls offer policy remedies for bloc’s stuttering economy"              
#>  [47] "Tory MP seeks to oust John Bercow as Commons Speaker"                          
#>  [48] "Reimagining education for the 21st century"                                    
#>  [49] "FT Health: The struggle for women’s rights"                                    
#>  [50] "UDI comparison is depressingly prophetic"                                      
#>  [51] "Five issues that could swing the Australian election"                          
#>  [52] "Britain can now change its mind about Brexit"                                  
#>  [53] "UK culture secretary shrugs off online regulation fears"                       
#>  [54] "Can the Algerian spring succeed after Bouteflika?"                             
#>  [55] "On the limits of a new AI-inspired Gosplan system"                             
#>  [56] "Breaking up the Big Four: EY, Deloitte, KPMG and PwC protest at UK reform"     
#>  [57] "Today’s MPs simply aren’t made of the right stuff"                             
#>  [58] "Leaving London: voices from the financial front lines of Brexit"               
#>  [59] "Pro-Europeans must unite around the opportunity of the EU elections"           
#>  [60] "Alec Russell on the joy of a Brexit detox"                                     
#>  [61] "A comedian for president? Don’t make me laugh"                                 
#>  [62] "Volodymyr Zelensky on track to win first round in Ukraine poll"                
#>  [63] "Britain’s other crisis"                                                        
#>  [64] "The EU has little appetite to grant another Brexit extension"                  
#>  [65] "Anti-corruption lawyer elected Slovakia’s first female president"              
#>  [66] "Ukrainian poll favourite Volodymyr Zelensky taps into public anger"            
#>  [67] "Theresa May’s Faustian pact to save a wretched Brexit"                         
#>  [68] "Theresa May allows a free vote on Brexit alternatives"                         
#>  [69] "Conservative Eurosceptics split over Theresa May’s Brexit deal"                
#>  [70] "Commodity traders have nothing to fear from transparency"                      
#>  [71] "Spain’s Albert Rivera shifts party rightward ahead of vote"                    
#>  [72] "Europe’s public interest problem with Chinese investment"                      
#>  [73] "Weekend catchup — this week’s personal finance headlines"                      
#>  [74] "Vestager discloses ambition to become next EU commission chief"                
#>  [75] "India is well placed to be a global economic force"                            
#>  [76] "Australia to cut immigration intake by 15 per cent"                            
#>  [77] "Is no-deal Brexit still possible next week?"                                   
#>  [78] "‘Mother’ has become an embarrassment"                                          
#>  [79] "Anti-corruption lawyer wins first round of Slovakia election"                  
#>  [80] "EU to probe where retail investors are getting a fair deal"                    
#>  [81] "‘Brexit? Just get on with it’ is the blunt message from Yorkshire"             
#>  [82] "Mark Zuckerberg tightens the reins at Facebook"                                
#>  [83] "Brexit confusion has roots in decades of mutual suspicion"                     
#>  [84] "Brexit has become a Monty Pythonesque joke"                                    
#>  [85] "Mediums, magicians and the all-too-fallible mind"                              
#>  [86] "Elephant and Castle shifts from social housing to ‘build to rent’"             
#>  [87] "How ‘indicative votes’ could resolve the Brexit impasse"                       
#>  [88] "Tory MPs vote with their feet as Philip Hammond sets out his plans"            
#>  [89] "EU liberal party forced to end corporate sponsorship after Macron pressure"    
#>  [90] "How Canada’s Justin Trudeau fell off his moral high horse"                     
#>  [91] "Luxembourg fears a lose-lose Brexit despite financial sector gains"            
#>  [92] "Luxembourg’s locals proudly hold their tongue in cultural mix"                 
#>  [93] "Michael Moritz, the tech investor backing books"                               
#>  [94] "Fintech Faceoff: are big US banks back?"                                       
#>  [95] "Listen: Pension freedoms: the unintended consequences revealed"                
#>  [96] "Dropping food tariffs would devastate farmers"                                 
#>  [97] "The way to fix bias in economics is to recruit more women"                     
#>  [98] "Anchor Hanover’s Jane Ashcroft: connecting with employees is key"              
#>  [99] "Slow-inflation conundrum prompts rethink at the Federal Reserve"               
#> [100] "European banks wield axe after bleak fourth quarter"
```
