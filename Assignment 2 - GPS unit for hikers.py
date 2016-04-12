# Import necessary methods.
import random
import haversine

__author__ = 'cycomikey'
'''
Date: 06/12/2015
Description:
1. Set and retrieve the current location. set the current location as a waypoint. Call it CurrentLocation.
2. Set and retrieve other user-defined waypoints.
3. Save and retrieve named paths consisting of a sequence of waypoints.
4. Calculate the distance to a given waypoint from the current location.
5. Calculate the direction as a compass bearing from the current location to a given waypoint. Range 0 <= bearing < 360
'''


class WayPoint:
    def __init__(self, longitude=0, latitude=0, name=""):
        self.longitude = random.uniform(-11.0, -5.0)
        self.latitude = random.uniform(51.0, 55.0)
        self.name = "Current Location"

    def __str__(self):
        CurrentLocation = "Current location is Longitude: {} and Latitude: {} {}".format(self.longitude, self.latitude\
                                                                                         , self.name)
        return CurrentLocation

    def distance(self, other):
        point1 = (self.long, self.lat)
        point2 = (other.long, other.lat)
        dist = haversine.haversine(point1, point2)
        return dist

    def direction(self, other):
        y = math.sin(other.long-self.long) *math. cos(other.lat)
        x = math.cos(self.lat)*math.sin(other.lat)-math.sin(self.lat)*math.cos(other.lat)*math.cos(other.long-self.long)
        bearing = round((math.degrees(math.atan2(y,x))+360)%360)
        return bearing


def User_Waypoints(waypoint_list):
    longitude = input("Please enter a longitude between -11 and -5.0")
    latitude = input("Please enter a latitude between 51.0 and 55.0")
    if float(longitude) >= -11.0 and float(longitude) <= -5.0:
        if float(latitude) >= 51.0 and float(latitude) <= 55.0:


            name = input("Please Enter a name for this waypoint.")
            temp_list = (longitude, latitude, name)
            waypoint_list.append(temp_list)
            return waypoint_list


        else:
            print("Invalid location please try again.")
    else:
        print("Invalid location please try again.")

def Display_waypoints(all_waypoints, waypoint_list):
    name = input("Please enter a name for this list ofw waypoints.")
    temp_list = (name, waypoint_list)
    all_waypoints.append(temp_list)
    print(all_waypoints)
    waypoint_list = []
    return waypoint_list




def main():
    all_waypoints = []
    waypoint_list = []
    while 1 == 1:
        print("\n1: Display Current Location.\n"
              "2: Enter a way-point.\n"
              "3: View list of locations.\n"
              "4: Calculate distance to a location.\n"
              "5: Calculate direction to a location.\n"
              "6: Exit.\n")

        num = input("Please select an option.")

        if num == "1":
            CurrentLocation = WayPoint()
            print(CurrentLocation)

        elif num == "2":
            waypoint_list = User_Waypoints(waypoint_list)

        elif num == "3":
            waypoint_list = Display_waypoints(all_waypoints, waypoint_list)

        elif num == "4":
            new_point=User_Waypoints(waypoint_list)
            print("{:.3f}".format(WayPoint.distance(CurrentLocation,new_point)), " km \n")

        elif num == "5":
            pass

        elif num == "6":
            print("The program will now end.")
            break



if __name__ == "__main__":
    '''
    Program Start.
    '''
    main()