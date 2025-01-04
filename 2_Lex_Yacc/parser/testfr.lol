numar sefu() {
    bul is_primenumar = minciuna;
    numar i =2;
    numar j = 2;
    numar count= 0 ;
    numar k = 0;

    citeste >> k;        
    
    cat (count < k) {
        is_prime = adevar;
        j = 2;
        
        cat (j * j <= i) {
            daca (i % j == 0) {
                is_prime = false;
            }
            j = j + 1;
        }

        daca (is_prime) {
            scrie << i << " ";  
            count = count + 1;
        }
            
        i = i + 1;
    }
    
    scrie << "\n" << "Primele prime gasite" << count << "\n";   
    
    rezulta 0;
}
