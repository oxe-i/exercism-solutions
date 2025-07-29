export class DiffieHellman {
  #p;
  #g;
  
  #isPrime(x) {
    return x > 1 && ((n) => {
      while (n * n <= x && x % n) n++;
      return (x % n);
    })(2)  
  }
  
  constructor(p, g) {
    if (!this.#isPrime(p)) throw new Error(`${p} is not prime.`);
    if (!this.#isPrime(g)) throw new Error(`${g} is not prime.`);
    [this.#p, this.#g] = [p, g];
  }

  getPublicKey(privateKey) {
    if (privateKey <= 1) throw new Error(`Private key must be greater than 1.`);
    if (privateKey >= this.#p) throw new Error(`Private key must be less than p.`);
    return (this.#g ** privateKey) % this.#p;
  }

  getSecret(theirPublicKey, myPrivateKey) {
    return (theirPublicKey ** myPrivateKey) % this.#p;
  }

  static getPrivateKey(p) {
    return (2 + Math.random() * (p - 2)) | 0;
  }
}
