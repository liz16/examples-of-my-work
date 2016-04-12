/*
Author Elizabeth Govan
Date:28/4/2015
Assignment  
due date 07/5/15


*/

#include<stdio.h>
#include<string.h>
#include<conio.h>
#include<stdlib.h>
#define SIZE 21


struct rec
{
    char team_a[SIZE];
    char team_b[SIZE];
    int goal_a;
    int goal_b;
};

//prototypes
void convert( FILE*,FILE*,struct rec );
void table (FILE*,char[],struct rec);
void display_h(FILE*,struct rec);
void search(FILE*,struct rec);
void add(FILE*,FILE*,struct rec);
main()
{
    // declaring and Initializing variables
    char oper;
    FILE *f1;
    FILE *f2;
    int i=0;
    struct rec single_rec;
    char *name[10]= {"Liverpool","Porto","PSG","Bayern Munich","Manchester Utd","Chelsea","Barcelona","Juventus","Real Madrid","Inter Milan"};
    // calling funtion convert.
    convert(f1,f2,single_rec);
   
    
    // do while optiond 5 has not pressed.
    do
    { 
        
        // menu   
        puts("______________________________________________________ ");
        puts("|Please enter one of the following options            |");
        puts("|1. Show table                                        |");
        puts("|2. Add match                                         |" );
        puts("|3. Display match with highest number of goals scored |");
        puts("|4. Search team                                       |");
        puts("|5. Exit program                                      |");
        puts("______________________________________________________ ");
        scanf("%1s",&oper);
        flushall();
            
        
       // the menu 
        switch(oper)
        {
            
            
            // option 1 is to show the league Table
            case'1':
            {
                puts("League Table");
                puts("______________________________________________________ ");
                puts("     Name            |Points|Goal Scored|Goal Conceded| ");
                 
                for(i=0;i<10;i++)
                {
                table (f2,name[i],single_rec);
                }
               
               
               
                break;
            }// end of case 1
            
            
            
            // option 2 will add a match 
            case'2':
            {
                // calling function add
                add(f1,f2,single_rec);                 
               break;
            }// end of case 2
            
            // option 3 will display the matches with the hightest goals 
            case'3':
            {
                // calling function display_h
                display_h(f2,single_rec);
                break;
            }// end of case 3
            
            // option 4 will seach and display all the matches a team has played
            case'4':
            {  
                // calling function search
                search(f2,single_rec);
                break;
            }// end of case 4
            
             // option 5 will end the program.
            case'5':
            {  
                puts("end program");
                break;
            }// end of case 5
            
            
            
            default:
            {
                // error checking
                puts("you have entered a incorrect option");  
                break;
            }// end of default 
            
            
            
        }// end of switch
      
        
    }// end of do while
     while(oper !='5');
        
getchar();
}// end of main()

//Convert a text file into a binary file.
void convert(FILE* f1,FILE* f2,struct rec single_rec)
{
    // opening file  matches.txt in r mode
    f1=fopen("matches.txt","r");
    
    // checking if file has opened.
    if(f1 == NULL)
    {
        printf("error\n");
    }
    else
    {
        printf("file open\n");
        
    }
    // opening file matches. bin in wb mode
    f2=fopen("matches.bin","wb");
    // checking if the file has opened
     if(f2== NULL)
    {
        printf("error\n");
    }
    else
    {
        printf("file open\n");
        
    }
    // reading the file one structure at a time
    while ( (fscanf(f1,"%[^,] , %[^,] , %i , %i\n",single_rec.team_a,single_rec.team_b,&single_rec.goal_a,&single_rec.goal_b))!=EOF)
	{
        // writing data to matches.bin one structure at a time
        fprintf(f2,"%s , %s , %i , %i\n",single_rec.team_a,single_rec.team_b,single_rec.goal_a,single_rec.goal_b);
	}	
   
    // closing files
    fclose(f1);
    fclose(f2);
}// end of fxn

// function to show table
void table (FILE*f2,char name[],struct rec single_rec)
{
    // declaring and Initializing variables
    int conceded=0;
    int points=0;
    int scored=0;
    int len;
        // finding the lenght of name
    len=strlen(name);
    
    // opening file matches.bin 
    f2=fopen("matches.bin","rb");
    // reading file one structure at a time
     while ( (fscanf(f2,"%[^,] , %[^,] , %i , %i\n",single_rec.team_a,single_rec.team_b,&single_rec.goal_a,&single_rec.goal_b))!=EOF)
	{
        // if name is the same as team a do the following
        if(memcmp(name,single_rec.team_a,len)==0)
        {
            
            scored=scored+single_rec.goal_a;
            conceded=conceded+single_rec.goal_b;
            // if goal a are the same as goal b add 1 point 
            if(single_rec.goal_a== single_rec.goal_b)
            {
                points = points + 1;
                
            }
            // if goal a is greater than goal b add 3 points
            else if (single_rec.goal_a>single_rec.goal_b)
            {
                points = points + 3 ;
            }
            
        }
        // if name it the same as name of team b do the following
        else if(memcmp(name,single_rec.team_b,len)==0)
        {
            scored=scored+single_rec.goal_b;
            conceded=conceded+single_rec.goal_a;
            // if goal b are the same as goal a add 1 point
            if(single_rec.goal_b==single_rec.goal_a)
            {
                points = points + 1;
                
            }
            // if goal b is greater than goal a add 3 points
            else if (single_rec.goal_b>single_rec.goal_a)
            {
                points = points + 3 ;
            }
            
        }
      
	}
    

// write to file 
printf("%s,%d,%d,%d\n",name,points,scored,conceded); 
fclose(f2);

}// end of function 

// function to display the matches with the most goals 
void display_h(FILE*f2,struct rec single_rec)
{
    // declaring and Initializing variables
    int goals = 0;
    int num=0;
    // open file matches.bin
    f2=fopen("matches.bin","rb");
    // check if file is open
    if(f2 == NULL)
    {
        printf("error\n");
    }
    else
    {
        printf("file open\n");
        
    }
    //reading file one structure at a time
    while ( (fscanf(f2,"%[^,] , %[^,] , %i , %i\n",single_rec.team_a,single_rec.team_b,&single_rec.goal_a,&single_rec.goal_b))!=EOF)
	{
        
        goals= single_rec.goal_a+single_rec.goal_b;
        // hights num 
        if(num<goals)
        {
            num=goals;
            
        }
        
    }
    printf("The higest number of goals scored is %d\n",num);
    // closing file
    fclose(f2);
    // opening file
    f2=fopen("matches.bin","rb");
    printf("Below are all the matches were the total amount of goals scored are %d\n",num);
    // reading file one strcture at a time
    while ( (fscanf(f2,"%[^,] , %[^,] , %i , %i\n",single_rec.team_a,single_rec.team_b,&single_rec.goal_a,&single_rec.goal_b))!=EOF)
    {
        goals= single_rec.goal_a+single_rec.goal_b;
        // goal are the same as num then print match.
        if (goals==num)
        {
           printf("Match between %s and %s goals: %i : %i\n" ,single_rec.team_a,single_rec.team_b,single_rec.goal_a,single_rec.goal_b); 
        }
    }   
}// end of fxn
// search all matches for said name.
void search(FILE*f2,struct rec single_rec)
{
    // declaring and Initializing variables
    char user_name[SIZE];
    char name_a[SIZE];
    char name_b[SIZE];
    int len;
    int counter=0;
    // input name
    puts("Please enter the Name of the team you want to search");
    puts("_____________________________________________________");
    gets(user_name);
    // finding the lenght of input name
    len = strlen(user_name);
    
    // opening file matches.bin
    f2=fopen("matches.bin","r");
    printf("Match played by  %s \n",user_name );
    puts("-------------------------------------------------------");
    // reading file one structrue at a time
    while ( (fscanf(f2,"%[^,] , %[^,] , %i , %i\n",single_rec.team_a,single_rec.team_b,&single_rec.goal_a,&single_rec.goal_b))!=EOF)
    {
        strcpy(name_a ,single_rec.team_a);
        strcpy(name_b ,single_rec.team_b);
        // if input name is the same as name of team a or the same as name of team b print match
        if(memcmp(name_a,user_name,len)==0||memcmp(name_b,user_name,len)==0)
        {
            printf("Match between %s and %s goals: %i : %i\n" ,single_rec.team_a,single_rec.team_b,single_rec.goal_a,single_rec.goal_b);
            counter++;
        }
	}
    //  if counter is 0 then there were no matches found with input name.
    if(counter==0)
    {
        puts("The team you are looking for is not in the file");
    }
}// end of fxn 

// add a match
void add(FILE*f1,FILE*f2,struct rec single_rec)
{
    // declaring and Initializing variables
    struct rec new_rec;
    // opening file  matches.txt
    f1=fopen("matches.txt","r+"); 
    // moving pointer to the end off the file
    fseek(f1,0,SEEK_END);
    // input data for team a
    puts("Enter Team A");
    gets(new_rec.team_a);
    puts("Enter the goals scored by Team A ");
    scanf("%d",&new_rec.goal_a);
    flushall();
    
    // input data for team b
    puts("Enter Team B");
    gets(new_rec.team_b);
    puts("Enter the goals scored by Team B ");
    scanf("%d",&new_rec.goal_b);
    flushall();
    // print to monitor
    printf("Match between %s and %s goals: %i : %i\n" ,new_rec.team_a,new_rec.team_b,new_rec.goal_a,new_rec.goal_b); 
    // add the file
    fprintf(f1,"%s,%s,%i,%i\n" ,new_rec.team_a,new_rec.team_b,new_rec.goal_a,new_rec.goal_b); 
    
    // calling function convert
    convert(f1,f2,single_rec);
    // closing files
    fclose(f1);
}

