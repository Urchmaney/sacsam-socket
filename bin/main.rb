require '../lib/data_layer'

DataLayer.exec(DataLayer.create_coordinates_table)
DataLayer.exec(DataLayer.add_coordinate('3344', '333', 1))
