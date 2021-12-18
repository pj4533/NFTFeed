### Building Notes

As a quick hack for handling secrets (like API keys), I just put them in a file that is excluded from git. 
1. Under the `NFTFeed` folder, create a file called `Secrets.swift`
2. In that file put this:
```
struct Secrets {
  let infuraProjectId = "<Your Infura Project ID Key>"
}
```
3. Then build normally

### Helpful Links

https://etid.wtd.ru

https://etherscan.io

https://www.pauric.blog/How-to-Query-and-Monitor-Ethereum-Contract-Events-with-Web3/

