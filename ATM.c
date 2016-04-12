/*
Author Elizabeth Govan
Date:28/2/2015
Assignment 2 
due date 11/3/15
security authorisation based on access codes.

*/

#include<stdio.h>
#include<string.h>
#include<conio.h>
#define SIZE 4

//prototypes
void enter_code(int*,int*,int*,int*);
void Encrypt_code(int*,int*,int*); 
void compare_code(int*,const int*,int*,int*);
void Decrypt_code(int*,int*,int*);
void display(int*,int*);
void exit();

main()
{
    // declaring and Initializing variables
    char oper;
    int  user_code[SIZE];
    const
    int access_code[SIZE]={4,5,2,3};
    int Incorrectly=0;
    int Successfully=0;
    int encrypt=0;
    int decrypt=0;
    int entered=0;
    
    
    
    do
    { 
        
        // menu    
        puts("Please enter one of the following options ");
        puts("1. Enter code");
        puts("2. Encrypt code and verify if correct" );
        puts("3. Decrypt code");
        puts("4. Display the number of times the code was entered");
        puts("   (i) Successfully (ii)Incorrectly ");
        puts("5. Exit program");
            
        scanf("%1s",&oper);
        flushall();
            
        
       // the menu 
        switch(oper)
        {
            
            
            // option 1 is to enter a code
            case'1':
            {
                clrscr();
                
                
                // call fxn enter_code
                enter_code(user_code,&encrypt,&decrypt,&entered);
                break;
            }// end of case 1
            
            
            
            // option 2 will encrypt the code 
            case'2':
            {
                clrscr();
                 if(entered==0)
                {
                    puts("you have not entered a code");
                }
                else
                {
                //calling the function encrypt 
                 Encrypt_code(user_code,&encrypt,&decrypt); 
                
                // calling the function compare code
                 compare_code(user_code,access_code,&Successfully,&Incorrectly);
                }//end of else
               break;
            }// end of case 2
            
            
            
            
            // option 3 will decrypt the code the user has enter
            case'3':
            {
                clrscr();
                // calling the  function decrypt code
                Decrypt_code(user_code,&encrypt,&decrypt);
                
                break;
            }// end of case 3
            
            
            
            // option 4 will display the variables successfully and incorrectly
            case'4':
            {
                clrscr();
                // calling the function display
                display(&Successfully,&Incorrectly); 
                break;
            }// end of case 4
            
            
            
            // option 5 will end the program
            case'5':
            {  
                clrscr();
                // calling function exit
                exit();
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

// implement enter code
/*This function is for entering a four digit code*/
void enter_code(int*user_code,int*encrypt,int*decrypt,int*entered)
{
    //variables
    int i;
    
    // display to user
    puts("please enter your 4 single-digit code");
    
    //  for loop to enter the code digit by digit
    for(i=0;i<SIZE;i++)
    {
        
        puts(" enter a digit");
        scanf("%d",& *(user_code+i));
        
        //error checking
        if( *(user_code+i)<= 9 && *(user_code+i)>= 0 )
        {

            
        }// end of if
        // if the digit is not between 10 and -1 display the following text
        else
        {
            puts("error in input");
            i--;
            
        }// end of else
    
    }// end of for loop
    
    // setting encrypt counter to 0 when a new code is enter
    (*encrypt)=0;
    
    //setting decrypt counter to 0 when a new code is enter
    (*decrypt)=0;
    
    //add 1 to counter entered
    (*entered)++;
    
}// end of fxn enter code


/*implement Encrypt code*/

// This function will encrypt the code the user has entered 
void Encrypt_code(int*user_code,int* encrypt,int* decrypt)
{
    //variables
    int i; 
    int swap;
    
    
    //if the encrypt counter is 1 then the code has beem encrypted and can not be encryted again
    if(*encrypt>=1)
    {
        puts("your code was already encrypted ");
        
    }
    else
    {
        
        // swapping numder 1 with 3
        swap = *(user_code+0); 
        *(user_code+0)=*(user_code+2);
        *(user_code+2)= swap;
        
        //swapping number 2 with 4
        swap = *(user_code+1);
        *(user_code+1)= *(user_code+3);
        *(user_code+3)= swap;
            
        for(i=0;i<SIZE;i++)  
        {
            //adding 1 to each digit
            *(user_code+i)=*(user_code+i)+1;
            
            //if a digit is 10 change to 0
            if(*(user_code+i)==10)
            {
                *(user_code+i)= 0;  
                
            }// end of if  
        }
        
        // add 1 to the encrypt counter 
        (*encrypt)++;
        
        // decrypt is reset to 0
        (*decrypt=0);
    }// end of else
   
}// end of  Encrypt code function


/* implement decrypt code*/
// function to decrypt the encrypt code the user entered
void Decrypt_code(int*user_code,int*encrypt,int*decrypt)
{
    //variables
    int i; 
    int swap;
   
        //if the has already beem decrypted display the following text
    if(*decrypt>=1)
    {
        puts("You cannot decryted this code because:\n The you hasn't entered a code\n or it has alreay been decrted ");
    }// end of if
    else
    {
        // once the code has been encrypted 
        if(*encrypt==1)
        {
             
            for(i=0;i<SIZE;i++)  
            {
                // take away 1 from each digit
                *(user_code+i)=*(user_code+i)-1;
                    
                // if ditgit = -1 change to 9
                if(*(user_code+i)==-1)
                {
                    *(user_code+i)= 9;  
                    
                }// end of if  
            }
                
            // swapping number1 with number 3
            swap = *(user_code+0); 
            *(user_code+0)=*(user_code+2);
            *(user_code+2)= swap;
            
            // swapping number2 with number 4
            swap = *(user_code+1);
            *(user_code+1)= *(user_code+3);
            *(user_code+3)= swap;
                
            //add 1 to the decrypt counter
            (*decrypt)++;
                
            // reset the encrypt counter to 0
            (*encrypt=0);
        }// end of if
        else
        {
            puts("your code is not encrypted");
            
        }// end of else
    }// end of else
}// end of function decrypt_code


// implement display
// this function with display the number of times a code has been entered successfully and incorrectly
void display(int*Successfully,int*Incorrectly)
{
 printf("The code has been enter %d times successfully and %d times incorrectly\n ",*Successfully,*Incorrectly);   
}// end of function display


// implement compare code
void compare_code(int*user_code,const int*access_code,int*Successfully,int*Incorrectly)
{
    //variables
    int i;
    int code=0;
    
    
    for(i=0;i<SIZE;i++)
        {
            // comparing  the access code to the code inputted by the user
            if(*(access_code+i)==*(user_code+i))
            {
                // a counter 
                code++;
            } 
            
        }// end of for loop
    
        //if code is 4 them all digit were right
        if(code==4)
        {
            puts("Correct code");
            (*Successfully)++;
                        
        }// end of if
        else
        {
            puts("Error code ");
            (*Incorrectly)++;
            
        }// end of else
    
}// end of function compare code

void exit()
{
    puts("The program will end once you press any key ");
    
}// end of function exit



