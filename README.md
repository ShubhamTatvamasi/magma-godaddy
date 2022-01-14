# magma-godaddy

Create a file `godaddy.keys` and add following keys:
```bash
GODADDY_API_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxx"
GODADDY_API_SECRET="xxxxxxxxxxxxxxxxxxxxxxxxxxx"
```

Update DNS entries for Magma Orchestrator.
```bash
./update-dns.sh 3.110.121.47 galaxy.shubhamtatvamasi.com
```

Delete DNS entries for Magma Orchestrator.
```bash
./update-dns.sh delete galaxy.shubhamtatvamasi.com
```
