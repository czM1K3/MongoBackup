# MongoBackup
This is container that takes backup of MongoDB. It is ment to be ran in Kubernetes as CronJob. Backup folder should be mounted as NFS share.

## Docker example
```bash
docker run --rm -e MONGODB_URI="your-mongodb-uri/database-to-backup" -v your-backup-path:/backup czm1k3/mongobackup
```
