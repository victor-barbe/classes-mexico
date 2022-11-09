public class BubbleSort {
    // We create our Java Class
    public static void main(String[] args) {
        // Our main will contains the initialization of our arrays and call the function
        // BUBBLE_SORT in order to sort the values
        int[] A = new int[] { 40, 4, 3, 8, 22, 6, 7, 30, 18 };
        int[] B = new int[A.length];
        // We have an array of integers A containing few integers. B is an empty array
        // with length = A length. He will receive the sorted array.
        BubbleSort myObj = new BubbleSort();
        // We create an instance of BubbleSort in order to call our program BUBBLE_SORT
        B = myObj.BUBBLE_SORT(A); // We call BUBBLE_SORT(A) and gives its return value to B.
        for (int i = 0; i < B.length; i++) { // We use a loop in order to print every values of B and show if they've
                                             // been correctly sorted.
            System.out.println(B[i]);
        }
    }

    // we define our function Bubble_sort that will sort an array
    public int[] BUBBLE_SORT(int[] A) {
        int pivot = 0;
        // we define a loop that travel every values from A between indexes 1 and
        // A.length. We do not need to start at 0 because we are moving values up and
        // down and highest values will be moved to top while lower will get located in
        // the beginning of the array.
        for (int j = 1; j < A.length; j++) {
            // we start by giving to pivot the current values of the iteration in A
            pivot = A[j];
            // We give to i the value of the previous index of j in order to compare two
            // adjacent values
            int i = j - 1;
            // while all the number arent sorted correctly, the highest number goes higher
            // on the list
            while (i >= 0 && A[i] > pivot) { // while this condition is verified, we move value from A[i] to A[i+1]
                A[i + 1] = A[i];
                i = i - 1;
                // the value of i goes down by one to make sure we only sort on time
            }
            A[i + 1] = pivot; // We've moved values and have to make sure that pivot value is still in the
                              // array. Thanks to the while loop, we can find it's location by giving him the
                              // index i+1
        }
        // we return the sorted array
        return A;
    }
}
