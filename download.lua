function AsketLoad(product)
  createTimer(1,function()
    if not cheatEngineIs64Bit() then print('Asket supports only x64 CE') return end
    if getCEVersion() < 7.5 then print('Asket supports only version >= 7.5 CE') return end

    local cepath = getCheatEngineDir():gsub('\\','\\\\')
    local appdata = os.getenv('APPDATA'):gsub('\\','\\\\')
    local size = getInternet().getURL('https://raw.githubusercontent.com/expika/asket/refs/heads/main/size')/1
    local f,s = io.open(cepath..'\\asket64.dll','r')

    if not f then
      print('❓  Downloading api')
    else
      s = f:seek('end')
      f:close()
      if size ~= s then
        os.remove(cepath..'\\asket64.dll')
        print('❓ Updating api')
      else
        asket = require('asket64')
        product = product
        asket.dec(getInternet().getURL('https://raw.githubusercontent.com/expika/asket/refs/heads/main/main.lua'):gsub('\n',''))
        return
      end
    end
    
    os.execute('echo Asket api downloading, please be patient & powershell -Command "Invoke-WebRequest -Uri https://github.com/expika/asket/raw/refs/heads/main/asket64 -OutFile '..appdata..'\\asket64"')
    os.rename(appdata..'\\asket64', cepath..'\\asket64.dll')

    t = createTimer()
    t.Interval = 100
    t.OnTimer = function()
      f = io.open(cepath..'\\asket64.dll','r')
      s = f:seek('end')
      f:close()
      if s == size then t.destroy() print('✔ Done') asket = require('asket64') end
    end
  end)
end
