require('ggmap')

createCoordinatesModel <- function(db.path=DBPATH) {
  models <- list(c("coordinates", "config/db/coordinatesTable.txt"))
  connection <- getConnection(db.path)
  createModels(connection, models)
  dbDisconnect(connection)
}


newLocations <- function(locations, db.path=DBPATH) {
  connection <- getConnection(db.path)
  ## Checking what locataions are not in db
  locations.clean <- locations[locations!=""]
  locations.clean <- locations.clean[!is.na(locations.clean)]
  locations.clean <- unique(locations.clean)
  coordinatesInDb <- dbReadTable(connection, 'coordinates')
  dbDisconnect(connection)
  locationsInDb <- coordinatesInDb$location
  locations.clean[!(locations.clean %in% locationsInDb)]
}

lookupAndAddCoordinates <- function(locations, db.path=DBPATH) {
  locations.new <- newLocations(locations, db.path=DBPATH)
  n <- length(locations.new)
  print(paste('Updating ', n, " locations."))
  if (n != 0 ) {
    coordinates <- geocode(locations.new)  # Use amazing API to guess
    ## approximate lat/lon from textual location data.
    ## with(locations, plot(lon, lat))
    coordinates.df <- data.frame(location=locations.new, coordinates)
    connection <- getConnection(db.path)
    dbWriteTable(connection, "coordinates", coordinates.df, append=TRUE)
    dbDisconnect(connection)
  }
  print('done')
}
