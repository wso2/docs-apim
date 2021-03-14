# Defining Data Tables

This section explains how to configure data tables to store the events you need to persist to carry out time series aggregation.

The data handled by WSO2 Stream Processor are stored in the following two types of tables:

-   **In-memory tables** : If no  store-backed tables are defined, data
    is stored in in-memory tables by default.

-   **Store-backed tables** : These are tables that are defined by you
    in an external database. For a list of database types supported and
    instructions to define table for different database types, see
    [Defining Tables for External Data Stores]({{base_path}}/install-and-setup/setup/si-setup/defining-tables-for-physical-stores) .      

### Adding primary and index keys

Both in-memory tables and tables backed by external databases support
primary and index keys. These are defined to allow stored information to
be searched and retrieved in an effective and efficient manner.

#### Adding primary keys

Attribute(s) within the event stream for which the event table is
created can be specified as the primary key for the table. The purpose
of primary key is to ensure that the value for a selected attribute is
unique for each entry in the table. This prevents the duplication of
entries saved in the table.

Primary keys are configured via the `         @PrimaryKey        `
annotation. Only one @PrimaryKey annotation is allowed per event table.

When several attributes are given within Primary key annotation (e.g
@PrimaryKey( 'key1', 'key2')), those attributes would act as a composite
primary key.

##### Syntax

``` sql
    @PrimaryKey('<attribute_1>')
    define table <event_table> (<attribute_1> <attribute_type>, <attribute_2> <attribute_type>, <attribute_3> <attribute_type>);
```

##### Example

``` sql
    @PrimaryKey('symbol')
    define table StockTable (symbol string, price float, volume long);
```

The above configuration ensures that each entry saved in the
`         StockTable        ` event table should have a unique value for
the `         symbol        ` attribute because this attribute is
defined as the primary key.

#### Adding indexes

An attribute within the event stream for which the event table is
created can be specified as the primary key for the table. This allows
the entries stored within the table to be indexed by that attribute.

Indexes are configured via the `         @Index        ` annotation.

An event table can have multiple attributes defined as index attributes.
However, only one `         @Index        ` annotation can be added per
event table.

##### Syntax

To index by a single attribute:

``` sql
    @Index('<attribute_1>')
    define table <event_table> (<attribute_1> <attribute_type>, <attribute_2> <attribute_type>, <attribute_3> <attribute_type>);
```

To index by multiple attributes:

``` sql
    @Index('<attribute_1>''<attribute_2>')
    define table <event_table> (<attribute_1> <attribute_type>, <attribute_2> <attribute_type>, <attribute_3> <attribute_type>);
```

##### Example

``` sql
    @Index('symbol')
    define table StockTable (symbol string, price float, volume long);
```

The above configuration ensures that the entries stored in the
`         StockTable        ` event table are indexed by the
`         symbol        ` attribute.

### Defining Tables for Physical Stores
  
