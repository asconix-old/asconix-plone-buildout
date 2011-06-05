#!/bin/sh

# This script backups the ZODB, the buildout files and custom configuration files

# create backup directory if not yet available
backup_dir=/var/plone/backup
backup_zodb_dir=$backup_dir/zodb
backup_blob_dir=$backup_dir/blob
backup_buildout_dir=$backup_dir/buildout
[ -d $backup_dir ] || mkdir $backup_dir
[ -d $backup_zodb_dir ] || mkdir $backup_zodb_dir
[ -d $backup_blob_dir ] || mkdir $backup_blob_dir
[ -d $backup_buildout_dir] || mkdir $backup_buildout_dir

# backup ZODB data
buildout_dir=/var/plone/buildout
python_cmd=/var/plone/bin/python
repozo_cmd=$buildout_dir/bin/repozo
zodb_file=$buildout_dir/var/filestorage/Data.fs
echo "ZODB backup started"
$python_cmd $repozo_cmd -Bvz -r $backup_zodb_dir -f $zodb_file
echo "ZODB backup finished"

# backup BLOB data
blob_dir=$buildout_dir/var/blobstorage
tar cvf $backup_blob_dir/`date +%Y-%m-%02d-%H-%M-%S`.tar $blob_dir

# backup buildout files
buildout_base_file=$buildout_dir/base.cfg
buildout_deployment_file=$buildout_dir/deployment.cfg
cp $buildout_base_file $backup_buildout_dir/base.cfg.`date +%Y-%m-%02d-%H-%M-%S`
cp $buildout_deployment_file $backup_buildout_dir/deployment.cfg.`date +%Y-%m-%02d-%H-%M-%S`
