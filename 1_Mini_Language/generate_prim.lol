număr x = 0;
număr i = 2;
bul flag;

cât (x < n) {
    flag = adevărat;
    j = 2;
    cât ( j <= sqrt(i) ) {
        dacă (i%j == 0) {
            flag = fals;
            j = sqrt(i) + 1;
        }
        j = j + 1;
    }
    dacă(flag){
        scrie(i);
        scrie(' ');
        x = x + 1;
    }
    i = i+1;
}
scrie('\n');