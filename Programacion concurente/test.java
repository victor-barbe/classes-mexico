public class test {
    public static void main(String arg [])
    {
        int[] tab = new int[] { 40, 4, 3, 8, 22, 6, 7, 30, 18 };
        int size = 9;     
        Bubble_sort xD = new Bubble_sort(tab,size);  
        System.out.println(xD.getSize());
        xD.getTableau();
    }

}

class Bubble_sort
{
    private int[] tableau;
    private int size;

    public Bubble_sort(int[] tableau, int size) {
        this.tableau = tableau;
        this.size = size;
    }

    public Bubble_sort(){}


    public int[] sort_array(int[] tableau, int size)
    {
        int pivot;
        for(int j = 2; j < tableau.length; j++)
        {
            pivot = tableau[j];
            int i = j - 1;
            while (i >= 0 && tableau[i] > pivot) { // while this condition is verified, we move value from A[i] to A[i+1]
                tableau[i + 1] = tableau[i];
                i = i - 1;

            }
            tableau[i + 1] = pivot;
        }
        return(tableau);

    }

    public int[] getTableau() {
        return tableau;
    }

    public void setTableau(int[] tableau) {
        this.tableau = tableau;
    }

    public int getSize() {
        return size;
    }

    public void setSize(int size) {
        this.size = size;
    }

}