#include <stdio.h>

//we define our function Bubble_sort that will sort an array
void Bubble_sort(int A[], int size)
    {
        //we define a loop that goes around the entiere array, we don't need to start at 0 because the low value will be sorted automatically by moving the others
        for (int j = 1 ; j < size ; j++)
            {
                //we define pivot variable to then compare the value
                int pivot = A[j];
                //we define an index to compare two value sitting next to the other
                int i = j - 1;

                while (i >= 0 && A[i] > pivot)
                    {
                        //while all the number arent sorted correctly, if the value in index i+1 is smaller, then it take the value of index i
                        A[i+1] = A[i];
                        //the value of i goes down by one to make sure we only sort on time
                        i = i - 1;
                    }
                //the value in i+1 takes the bigger value as it should
                A[i+1] = pivot;
            }  
    }

void display_array(int A[], int size)
    {
        for(int i = 0; i < size; i++)
        {
          printf("%d   ", A[i]);  
        }
    }
//we define the main that will call the function to sort an array
int main( int argc, char *argv[])
    {
        //we define the size of the array
        int size = 6;
        //we define the array we want to sort
        int A[]= {170,4,12,64,15,11};
        //we call the function to sort the array we just defined
        Bubble_sort(A, size);
        //we now display the array sorted in the correct way
        display_array(A, size);
        return(0);
    }

