A simple rails project to grab all your tweets, store them at your end, visualize who you talk to and who you retweet etc. It also visualizes which places you frequently visit while tweeting from there. 

# Configuration
1. clone the repository
2. create a file called twitter_credentials_.json in the root folder of the application and enter it according to the twitter_credentials_.json.example
3. migrate the database
4. start to populate the database with your tweets. You can use rake tweets:get for this. Currently there is no automatic behind it, so make sure you start a cronjob for this. 
5. you might have to run rake sunspot:solr:run to enable solr-searching. The indexing is already implemented, but a search-function isn't. 
6. Have fun 

# Dependencies & APIs used.
1. Solr using [*Sunspot*](http://sunspot.github.com/)
2. [*Google Chart Tools*](http://code.google.com/apis/chart/)
3. [*Google Maps API*](https://developers.google.com/maps/) (requires API key)
4. [*Heatmap.js*](http://www.patrick-wied.at/static/heatmapjs/)

# Example
An example deployment can be found at [*The Phylomemetic Tree*](http://phylomemetic-tree.de/twitter)