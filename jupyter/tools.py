import pandas


def showDF(df, limitRows=5, truncate=True):
    '''
    Helper for pretty formatting for Spark DataFrames
    '''
    if(truncate):
        pandas.set_option('display.max_colwidth', 50)
    else:
        pandas.set_option('display.max_colwidth', None)
    pandas.set_option('display.max_rows', limitRows)
    display(df.limit(limitRows).toPandas())
    pandas.reset_option('display.max_rows')


def _cd_kind(row):
    if row.kind == 'regular':
        return ''
    elif row.kind == 'clustering':
        order_char = '↑' if row.clustering_order == 'asc' else '↓'
        return 'C' + order_char
    else:
        return 'K'


def examineCassandraTable(session, keyspace_name, table_name, caption=True):
    '''
    Helper to construct a quick recap of a table's structure
    as a printable string.

    DO NOT USE ON PRODUCTION TABLES
    '''
    EXAMINE_CQL = 'SELECT column_name, clustering_order, kind, position, type FROM system_schema.columns WHERE keyspace_name=%s AND table_name=%s;'
    _grp = {'partition_key': 0, 'clustering': 1, 'regular': 2}
    rows = sorted(
        session.execute(EXAMINE_CQL, (keyspace_name, table_name)),
        key=lambda row: (_grp[row.kind], row.position, row.column_name),
    )
    max_name_len = max(len(row.column_name) for row in rows)
    max_type_len = max(len(row.type) for row in rows)
    line_formatter = f'  %-2s %-{max_name_len}s   %-{max_type_len}s    ⇒  %s'

    sample_row = session.execute(f'SELECT * from {keyspace_name}.{table_name} LIMIT 1;').one()

    schema_str = '\n'.join(
        line_formatter % (
            _cd_kind(row),
            row.column_name,
            row.type.upper(),
            getattr(sample_row, row.column_name) if sample_row else '',
        )
        for row in rows
    )
    if caption:
        preamble0 = f'TABLE {keyspace_name}.{table_name}:'
        preamble1 = '-' * len(preamble0)
        preamble = '%s\n%s\n' % (preamble0, preamble1)
    else:
        preamble = ''
    return preamble + schema_str
