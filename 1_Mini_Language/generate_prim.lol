număr x = 0;
număr i = 2;
bul steag;

cât (x < n) {
    steag = adevărat;
    j = 2;
    cât ( j <= sqrt(i) ) {
        dacă (i%j == 0) {
            steag = fals;
            j = sqrt(i) + 1;
        }
        j = j + 1;
    }
    dacă(steag){
        scrie(i);
        scrie(' ');
        x = x + 1;
    }
    i = i+1;
}
scrie('\n');