# replace_uuid-ossp_with_pgcrypto.sed
s/uuid-ossp/pgcrypto/g
s/uuid_generate_v4/gen_random_uuid/g
