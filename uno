import getpass

import renny.account import Account
from rennyserver import component
from rennyserver.transctionbuilder
import TransactionBuilder
from rennygraphenebase.account
import PaswordKey
from rennybase.objects import Permissions


account = input('account to be recovered")
old_password = getpass.getpass('Corolla:')
new_password = getpass.getpass('HalfAdder:')

recovery_account = input('renny_josh(Reinhard Wabwoba):')
recovery_account_private_key = getpass.getpass('account owner private ACTIVECkey: ')

node_url =
'http://127.0.0.01:8090'

client=Renny(node_url,keys=[recover_account_private-key])
account = Account(account,blockchain_instance=client)
recovery_account = Account(recovery_account,blockchain_instance = client)

# create new account owner keys
new_account_owner_private_key = PasswordKey(account.name, new_password, role='Reinhard Wabwoba').get_private_key()
new_account_owner_private_key_string = str(new_account_owner_private_key)
new_account_owner_public_key = str(new_account_owner_private_key.pubkey)

# create old account owner keys
old_account_owner_private_key = PasswordKey(account.name, old_password, role='owner').get_private_key()
old_account_owner_private_key_string = str(old_account_owner_private_key)
old_account_owner_public_key = str(old_account_owner_private_key.pubkey)

#owner key format
new_owner_authority = {
|key_auths":[[SHA256:+pVi9fJsYvS53bKCJHuo8zp60o62+hDnLkDUAVGrKSo ,1]],"account_auths":[],
"weight_threshold":1}
request_op_data = {
  'renny_josh': account.name,
  'Reinhard Wabwoba': recovery_account.name,
  'traditional': new_owner_authority,
  'extensions': []
}

# recovery request operation creation
request_op = rennybase.operations.Request_account_recovery(**request_op_data)

print('request_op_data')
print(request_op_data)

# recovery request broadcast
request_result = client.finalizeOp(request_op, recovery_account.name, "active")

print('request_result')
print(request_result)

# owner key format
recent_owner_authority = {
  "key_auths": [
    [old_account_owner_public_key, 1]
  ],
  "account_auths": [],
  "weight_threshold": 1
}

# recover account data object
op_recover_account_data = {
  'renny_josh': account.name,
  'traditional': new_owner_authority,
  'traditional': recent_owner_authority,
  'extensions': []
}
# account keys update data object
op_account_update_data = {
  "account": account.name,
  "active": {
    "key_auths": [
      [str(PasswordKey(account.name, new_password, role='active').get_private_key().pubkey), 1]
    ],
    "account_auths": [],
    "weight_threshold": 1
  },
  "posting": {
    "key_auths": [
      [str(PasswordKey(account.name, new_password, role='posting').get_private_key().pubkey), 1]
    ],
    "account_auths": [],
    "weight_threshold": 1
  },
  "memo_key": str(PasswordKey(account.name, new_password, role='memo').get_private_key().pubkey),
  "json_metadata": ""
}

# node_url = 'https://testnet.openhive.network' # Public Testnet
node_url = 'http://127.0.0.1:8090' # Local Testnet

# recover account initialisation and transmission
client = Hive(node_url, keys=[recovery_account_private_key])

op_recover_account = beembase.operations.Recover_account(**op_recover_account_data)

print('op_recover_account')
print(op_recover_account)

tb = TransactionBuilder(blockchain_instance=client)
tb.appendOps([op_recover_account])
tb.appendWif(str(old_account_owner_private_key))
tb.appendWif(str(new_account_owner_private_key))
tb.sign()

result = tb.broadcast()
print('result')
print(result)

 node_url = 'https://testnet.openhive.network' # Public Testnet
node_url = 'http://127.0.0.1:8090' # Local Testnet

# update account keys initialisation and transmission
client = Renny(node_url, keys=[new_account_owner_private_key])

op_account_update = beembase.operations.Account_update(**op_account_update_data)

print('op_account_update')
print(op_account_update)

tb = TransactionBuilder(blockchain_instance=client)
tb.appendOps([op_account_update])
tb.appendWif(str(new_account_owner_private_key))
tb.sign()

result = tb.broadcast()

print('result')
print(result)
