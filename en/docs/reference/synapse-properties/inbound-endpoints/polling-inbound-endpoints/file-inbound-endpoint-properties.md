# File Inbound Endpoint
## Introduction

The file inbound protocol is an alternative to the VFS transport. It uses the <b>VFS</b> transport to process files in a specified source directory. After processing the files, it moves them to a specified location or deletes them. Note that if files remain in the source directory after processing, they will be processed again. Therefore, if you need to maintain these files or keep track of the files that are processed, specify the option to move them instead of deleting them after processing.

## Parameters

See the list of [VFS parameters]({{base_path}}/reference/synapse-properties/transport-parameters/vfs-transport-parameters) that can be used with proxy services.