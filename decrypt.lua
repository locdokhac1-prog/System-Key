-- Lua Decryption Script
-- Key: 1234567890ABCDEF

local function decrypt_file(encrypted_str, key)
    -- Remove header
    local data_str = encrypted_str:match("@Encrypted response By DarkingCheater,(.+)")
    
    if not data_str then
        error("Invalid encrypted file format")
    end
    
    -- Parse encrypted bytes
    local encrypted_bytes = {}
    for byte_str in data_str:gmatch("[^,]+") do
        table.insert(encrypted_bytes, tonumber(byte_str))
    end
    
    -- XOR decrypt
    local key_bytes = {}
    for i = 1, #key do
        table.insert(key_bytes, string.byte(key, i))
    end
    
    local decrypted = ""
    for i = 1, #encrypted_bytes do
        local key_byte = key_bytes[((i - 1) % #key_bytes) + 1]
        local decrypted_byte = bit.bxor(encrypted_bytes[i], key_byte)
        decrypted = decrypted .. string.char(decrypted_byte)
    end
    
    return decrypted
end

-- Read encrypted file
local encrypted_content = io.open("_raw.lua", "r"):read("*a")

-- Decrypt with key
local key = "1234567890ABCDEF"
local decrypted_content = decrypt_file(encrypted_content, key)

-- Write decrypted file
local output_file = io.open("_decrypted.lua", "w")
output_file:write(decrypted_content)
output_file:close()

print("✅ Decryption complete!")
print("Output: _decrypted.lua")
