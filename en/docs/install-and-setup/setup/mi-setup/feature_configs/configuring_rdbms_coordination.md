# RDBMS Coordination Configuration

## RDBMS Coordination Parameters

The WSO2 Integrator: MI uses configurable heartbeat parameters to detect node failures in an RDBMS-based cluster. These parameters control how frequently nodes communicate their health status to the coordination database and how many failures are tolerated before a node is considered to have left the cluster.

The following parameters can be configured either as system properties or environment variables:

<table>
    <tr>
        <th>
            Parameter
        </th>
        <th>
            Type
        </th>
        <th>
            Default Value
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            <code>heartBeatInterval</code>
        </td>
        <td>
            Integer (milliseconds)
        </td>
        <td>
            <code>5000</code>
        </td>
        <td>
            The time interval at which each node sends heartbeat signals to the database to indicate it is alive and operational.
        </td>
    </tr>
    <tr>
        <td>
            <code>heartbeatMaxRetry</code>
        </td>
        <td>
            Integer (count)
        </td>
        <td>
            <code>3</code>
        </td>
        <td>
            The number of consecutive failed heartbeat attempts allowed before a node is considered to have left the cluster. This value must be greater than 0. Combined with <code>heartBeatInterval</code>, the node failure detection timeout is calculated as: <code>heartBeatInterval × heartbeatMaxRetry</code>.
        </td>
    </tr>
</table>

!!! Note
    Using the default values (5000ms and 3), the node failure detection timeout is **15 seconds** (5000ms × 3). This means a node is considered to have left the cluster 15 seconds after it stops sending heartbeat signals. Adjust these values based on your network stability and cluster responsiveness requirements.

## Rolling Updates for RDBMS Coordination Heartbeat Parameters

### Overview

When changing heartbeat parameters in a running cluster, a two-phase rolling restart is required to prevent task duplication. The cluster must maintain the invariant: **eviction threshold ≥ longest heartbeat interval** at all times.

### The Problem

Mixing old and new configurations can cause nodes with a tighter threshold to incorrectly declare slower peers as dead, triggering task duplication.

Eviction threshold = `heartBeatInterval × heartbeatMaxRetry`


### Two-Phase Approach

#### For Tightening (Reducing Threshold)

**Example:** 40s × 5 (200s threshold) → 10s × 3 (30s threshold)

**Phase 1: Update interval, pad retry count**
- Change to: `interval=10s, maxRetry=20` (threshold stays 200s)
- Roll one node at a time until all are on Phase 1

**Phase 2: Tighten retry count**
- Change to: `interval=10s, maxRetry=3` (threshold 30s)
- Roll one node at a time until all are on target config

#### For Loosening (Increasing Threshold)

**Phase 1:** Increase `maxRetry` first (keeps interval steady)

**Phase 2:** Then increase `heartBeatInterval`

This ensures the threshold always stays ≥ the longest interval in the cluster.

### What NOT to Do

❌ Do not change both parameters at once to tighten the threshold in a single rolling restart. This creates a window where new nodes' thresholds are narrower than old nodes' intervals, causing task duplication.

### Alternative

If a maintenance window is acceptable, shut down all nodes, update all configs simultaneously to target values, and restart together.
