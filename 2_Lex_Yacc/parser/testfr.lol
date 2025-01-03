număr șefu() {
    bul is_primenumăr;

    număr i = 2;
    număr j  = 2;
    număr count = 0;
    număr k = 0 ;
    
    scrie >> k;        
    cât (count < k) {
        is_prime = true;
        j = 2;
        
        cât (j * j <= i) {
            dacă (i % j == 0) {
                is_prime = false;
            }
            j = j + 1;
        }
        
        dacă (is_prime) {
            scrie << i << " ";  
            count = count + 1;
        }
        
        i = i + 1;
    }
    
    scrie << "\n" << "Primele prime gasite" << count << "\n";
    
    rezultă 0;
}
