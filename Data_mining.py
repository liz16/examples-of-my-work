'''Your program should calculate the monthly average price for Google
 and tell us the best and worst six-month period for Google.
The average price is defined as ((v1*c1)+(v2*c2)+(v3*c3)+(v4*c4)...+(vn*cn)) / (v1+v2+v3+v4...+vn)
where vi is the volume for day i and ci is the adjusted close price for day i.'''
# date: 22/10/15
from operator import itemgetter

# This function displays the best and worst 6 months.
def sort_months(list_avg):

  # sorts the list 'list_sort' by the second element highest to lowest.
    list_avg.sort(key=itemgetter(1), reverse=True)
    print("The best six months:\n_______________")
    for i in list_avg[0:6]:
        print( i[0], "{0:.2f}".format(i[1]))

    # recverse the list 'list_sort' by the second element lowest to highest.
    list_avg.reverse()
    print("\nThe worse six months:\n______________")
    for i in list_avg[0:6]:
        print( i[0], "{0:.2f}".format(i[1]))

    return None

# Function to calculate the monthly averages
def monthly_avg(Vol_X_Clo, Vol, current_month, list_avg):
    avg = Vol_X_Clo / Vol
    tuple = current_month, avg
    list_avg.append(tuple)
    return list_avg

def main():

    try:
        current_month = None
        list_avg = []
        Vol_X_Clo = 0.0
        Vol = 0.0

        #i renamed the google file to Data.csv as described on webcouses.
        file = open("Data.csv", "r")
        file_headers = file.readline()

        for line in file:
            # formatting Data
            line = line.strip('",\n').split(',')
            month = str(line[0].split('-')[0]+"-"+ line[0].split('-')[1])
            if current_month==None:
                current_month=month
                continue

            # if the month has not changed
            if current_month == month:

                # multiple the volume by the adj close and add it to the previous total.
                Vol_X_Clo = (Vol_X_Clo + (float(line[5])) * (float(line[6])))

                # Keep adding all the volume values together.
                Vol = (Vol + float(line[5]))

            # if the month has changed
            else:

                # get the average and add to list
                list_avg = monthly_avg (Vol_X_Clo,Vol,current_month,list_avg)
                current_month=month

                # initialisting to 0.
                Vol_X_Clo=Vol=0
        # get the average and add to list
        list_avg = monthly_avg (Vol_X_Clo,Vol,current_month,list_avg)
        # Display Best and worst.
        sort_months(list_avg)
    except IOError as e:
        print(e)

if __name__ == '__main__':

    main()
