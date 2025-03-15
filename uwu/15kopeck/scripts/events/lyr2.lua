    --ПОШЛО ГОВНО 
function onCreatePost()
    --Создание и настройка текста
        makeLuaText("big1", '', 0, 0, 0)
        setTextFont("big1", "AkiraExpanded-SuperBold.ttf")
        setObjectCamera("big1", 'game')
        setTextColor("big1", "FFFFFF")
        setTextBorder("big1", 5, "000000")
        setTextSize("big1", 90)
        setProperty("big1.antialiasing", true)
        setTextWidth("big1", 2000)
        screenCenter("big1", x)
        setProperty('big1.y', 1000)
        addLuaText("big1")
end
        -----------------------------------------------------------------------------
function onUpdatePost(elapsed)
    if songName == 'bing-chillin'  and eventName == 'lyr2' then
	screenCenter("big1", xy)
end
end


-- Ивент для ИНГЛИШ текста
    function onEvent(eventName, value1, value2)
        if eventName == 'lyr2' and value1 == 'r' then
            setTextColor("big1", "ff2c2c")
        elseif value1 == 'w' and eventName == 'lyr2' then
            setTextColor("big1", "FFFFFF")
        elseif value1 == '2' and eventName == 'lyr2' then
            setTextString("big1", value2)
        doTweenY("bigy", "big1", 600, 1, "backOut")
        doTweenAlpha("biga", "big1", 1, 1.1, "linear")
        elseif value1 == '0' and eventName == 'lyr2'then
            doTweenY("bigy", "big1", 1000, 0.5, "backIn")
            doTweenAlpha("biga", "big1", 0, 0.5, "linear")
    end

    if songName == 'bing-chillin'  and eventName == 'lyr2' then

        setTextSize("big1", 120)
        setTextFont("big1", "AE.ttf")
    end

    if songName == 'zdraiveri' and eventName == 'lyr2' then
    --    setObjectCamera("big1", 'HUD')
        setProperty('big1.y', 590)
        if value2 == '1' then
            setTextString("big1", 'Л')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '2' then
            setTextString("big1", 'ЛС')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '3' then
            setTextString("big1", 'ЛСД')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '4' then
            setTextString("big1", 'ЛСД хочу')
            setTextColor("big1", "ff2c2c")
        end

        if value2 == '5' then
            setTextString("big1", 'Нет')
        end
        if value2 == '6' then
            setTextString("big1", 'Трав')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '7' then
            setTextString("big1", 'Травки')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '8' then
            setTextString("big1", 'М')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '9' then
            setTextString("big1", 'Мм')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '10' then
            setTextString("big1", 'Ммм..')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '11' then
            setTextString("big1", 'Ммм.. нет')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '12' then
            setTextString("big1", 'ЛС')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '13' then
            setTextString("big1", 'ЛСД')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '14' then
            setTextString("big1", '[anime noise]')
        end
        if value2 == '15' then
            setTextString("big1", 'Трав')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '16' then
            setTextString("big1", 'Травки')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '17' then
            setTextString("big1", 'Травки мо')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '18' then
            setTextString("big1", 'Травки может')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '190' then
            setTextString("big1", 'Ну')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '19' then
            setTextString("big1", 'Ну что же')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '20' then
            setTextString("big1", 'Ну что же де')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '21' then
            setTextString("big1", 'Ну что же дела')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '22' then
            setTextString("big1", 'Ну что же делать?')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '23' then
            setTextString("big1", 'А')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '24' then
            setTextString("big1", 'А да')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '25' then
            setTextString("big1", 'А дава')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '26' then
            setTextString("big1", 'А давайте')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '27' then
            setTextString("big1", 'А давайте най')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '28' then
            setTextString("big1", 'А давайте найдём')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '29' then
            setTextString("big1", 'Ди')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '31' then
            setTextString("big1", 'Дилл')
        end
        if value2 == '32' then
            setTextString("big1", 'Диллера')
        end
        if value2 == '33' then
            setTextString("big1", 'А')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '34' then
            setTextString("big1", 'А где')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '35' then
            setTextString("big1", 'А где же')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '36' then
            setTextString("big1", 'А где же нам')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '37' then
            setTextString("big1", 'А где же нам его')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '38' then
            setTextString("big1", 'А где же нам его взять?')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '39' then
            setTextString("big1", 'Ди')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '40' then
            setTextString("big1", 'Дилл')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '41' then
            setTextString("big1", 'Диллеры')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '42' then
            setTextString("big1", 'Диллеры обы')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '43' then
            setTextString("big1", 'Диллеры обычно')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '44' then
            setTextString("big1", 'Диллеры обычно чёр')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '45' then
            setTextString("big1", 'Диллеры обычно чёрные')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '46' then
            setTextString("big1", 'Как')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '47' then
            setTextString("big1", 'Как этот')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '48' then
            setTextString("big1", 'Как этот па')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '49' then
            setTextString("big1", 'Как этот парень')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '50' then
            setTextString("big1", 'Да')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '51' then
            setTextString("big1", 'Давай')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '52' then
            setTextString("big1", 'Давайте')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '53' then
            setTextString("big1", 'Давайте его')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '54' then
            setTextString("big1", 'Об')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '55' then
            setTextString("big1", 'Обшмо')
        end
        if value2 == '56' then
            setTextString("big1", 'Обшмона')
        end
        if value2 == '57' then
            setTextString("big1", 'Обшмонаем')
        end
        if value2 == '58' then
            setTextString("big1", '*охуевание*')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '59' then
            setTextString("big1", 'От')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '60' then
            setTextString("big1", 'Отли')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '61' then
            setTextString("big1", 'Отличная')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '62' then
            setTextString("big1", 'Отличная и')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '63' then
            setTextString("big1", 'Отличная иде')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '64' then
            setTextString("big1", 'Отличная идея')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '65' then
            setTextString("big1", 'З')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '66' then
            setTextString("big1", 'Здр')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '67' then
            setTextString("big1", 'Здрай')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '68' then
            setTextString("big1", 'Здрайве')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '69' then
            setTextString("big1", 'Здрайверы')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '70' then
            setTextString("big1", 'А')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '71' then
            setTextString("big1", 'А да')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '72' then
            setTextString("big1", 'А давай')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '73' then
            setTextString("big1", 'А давайте')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '74' then
            setTextString("big1", 'А давайте е')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '75' then
            setTextString("big1", 'А давайте еба')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '76' then
            setTextString("big1", 'А давайте ебашить')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '77' then
            setTextString("big1", 'Без')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '78' then
            setTextString("big1", 'Без ос')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '79' then
            setTextString("big1", 'Без оста')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '80' then
            setTextString("big1", 'Без остано')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '81' then
            setTextString("big1", 'Без остановки')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '82' then
            setTextString("big1", 'Ёб')
        end
        if value2 == '83' then
            setTextString("big1", 'Ёбним')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '84' then
            setTextString("big1", 'Но')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '85' then
            setTextString("big1", 'Носо')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '86' then
            setTextString("big1", 'Носоро')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '87' then
            setTextString("big1", 'Носорога')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '88' then
            setTextString("big1", 'У')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '89' then
            setTextString("big1", 'У меня')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '90' then
            setTextString("big1", 'У меня есть')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '91' then
            setTextString("big1", 'У меня есть и')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '92' then
            setTextString("big1", 'У меня есть идея!')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '93' then
            setTextString("big1", '[woman drugs noise]')
            setTextColor("big1", "ff2c2c")
        end
        if value2 == '94' then
            setTextString("big1", 'По')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '95' then
            setTextString("big1", 'Повто')
            setTextColor("big1", "FFFFFF")
        end
        if value2 == '96' then
            setTextString("big1", 'Повторим?')
            setTextColor("big1", "ff2c2c")
        end
    end

-- Русские субтитры для The Girl From Far in Blue Sky [42]
    if songName == 'kvartira 42' and eventName == 'lyr2' then
        if value2 == '1' then
        setTextString("big1", 'Милый...')
        setTextColor("big1", "ff2c2c")
        end
        if value2 == '2' then
        setTextString("big1", 'Мне')
        setTextColor("big1", "FFFFFF")
        elseif value2 == '3' then
        setTextString("big1", 'Мне очень')
        elseif value2 == '4' then
        setTextString("big1", 'Мне очень жаль')
        setTextColor("big1", "ff2c2c")
        elseif value2 == '5' then
        setTextString("big1", 'Что')
        setTextColor("big1", "FFFFFF")
        elseif value2 == '6' then
        setTextString("big1", 'Что так')
        elseif value2 == '7' then
        setTextString("big1", 'Что так получилось')
        setTextColor("big1", "ff2c2c")
    end

    if value2 == '8' then
        setTextString("big1", 'Нет!')
    elseif value2 == '9' then
        setTextString("big1", 'Ты..')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '10' then
        setTextString("big1", 'Не')
    elseif value2 == '11' then
        setTextString("big1", 'Не так')
    elseif value2 == '13' then
        setTextString("big1", 'Понял..')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '14' then
        setTextString("big1", 'Я')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '15' then
        setTextString("big1", 'Я не')
    elseif value2 == '16' then
        setTextString("big1", 'Я не хочу')
    elseif value2 == '17' then
        setTextString("big1", 'Я не хочу  тебя')
    elseif value2 == '18' then
        setTextString("big1", 'Потерять')
        setTextColor("big1", "ff2c2c")
    end

    if value2 == '19' then
        setTextString("big1", 'Я бу')
    elseif value2 == '20' then
        setTextString("big1", 'Я буду')
    elseif value2 == '21' then
        setTextString("big1", 'Я буду вме')
    elseif value2 == '22' then
        setTextString("big1", 'Я буду вместо')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '23' then
        setTextString("big1", 'вме')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '24' then
        setTextString("big1", 'вместо')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '25' then
        setTextString("big1", 'не')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '26' then
        setTextString("big1", 'неё')
        setTextColor("big1", "ff2c2c")
    end

    if value2 == '27' then
    setTextString("big1", 'Не')
    setTextColor("big1", "FFFFFF")
    elseif value2 == '28' then
    setTextString("big1", 'Небо')
    elseif value2 == '29' then
    setTextString("big1", 'Небо у')
    elseif value2 == '30' then
    setTextString("big1", 'Небо уро')
    elseif value2 == '31' then
    setTextString("big1", 'Небо уронит')
    setTextColor("big1", "ff2c2c")
    elseif value2 == '32' then
    setTextString("big1", 'Ночь')
    setTextColor("big1", "FFFFFF")
    elseif value2 == '33' then
    setTextString("big1", 'Ночь на')
    elseif value2 == '34' then
    setTextString("big1", 'Ночь на ла')
    elseif value2 == '35' then
    setTextString("big1", 'Ночь на ладо')
    elseif value2 == '36' then
    setTextString("big1", 'Ночь на ладони')
    setTextColor("big1", "ff2c2c")
    elseif value2 == '37' then
    setTextString("big1", 'Нac')
    setTextColor("big1", "FFFFFF")
    elseif value2 == '38' then
    setTextString("big1", 'Нас не')
    elseif value2 == '39' then
    setTextString("big1", 'Нас не до')
    elseif value2 == '40' then
    setTextString("big1", 'Нас не дого')
    elseif value2 == '41' then
    setTextString("big1", 'Нас не догонят')
    setTextColor("big1", "ff2c2c")
    elseif value2 == '42' then
    setTextString("big1", 'Я со')
    elseif value2 == '43' then
    setTextString("big1", 'Я сошла')
    elseif value2 == '44' then
    setTextString("big1", 'Я сошла с')
    elseif value2 == '45' then
    setTextString("big1", 'Я сошла с ума')
    setTextColor("big1", "ff2c2c")
    elseif value2 == '46' then
    setTextString("big1", 'Я сошла с у')
    setTextColor("big1", "FFFFFF")
    end

    if value2 == '47' then
    setTextString("big1", 'Да')
    setTextColor("big1", "FFFFFF")
    elseif value2 == '48' then
    setTextString("big1", 'Давай')
    elseif value2 == '49' then
    setTextString("big1", 'Давай спо')
    elseif value2 == '50' then
    setTextString("big1", 'Давай спокой')
    elseif value2 == '51' then
    setTextString("big1", 'Давай спокойно')
    elseif value2 == '52' then
    setTextString("big1", 'Давай спокойно пого')
    elseif value2 == '53' then
    setTextString("big1", 'Давай спокойно погово')
    elseif value2 == '54' then
    setTextString("big1", 'Давай спокойно поговорим')
    setTextColor("big1", "ff2c2c")
    elseif value2 == '55' then
    setTextString("big1", 'Про')
    setTextColor("big1", "FFFFFF")
    elseif value2 == '56' then
    setTextString("big1", 'Прошу...')
    setTextColor("big1", "ff2c2c")
    elseif value2 == '57' then
    setTextString("big1", 'Как')
    elseif value2 == '58' then
    setTextString("big1", 'Как ска')
    elseif value2 == '59' then
    setTextString("big1", 'Как скажешь')
    setTextColor("big1", "ff2c2c")
    end

    if value2 == '60' then
    setTextString("big1", 'Хо')
    setTextColor("big1", "FFFFFF")
    elseif value2 == '61' then
    setTextString("big1", 'Хочешь')
    setTextColor("big1", "ff2c2c")
    elseif value2 == '62' then
        setTextString("big1", 'сла')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '63' then
        setTextString("big1", 'сладких')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '64' then
        setTextString("big1", 'сладких а')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '65' then
        setTextString("big1", 'сладких апель')
    elseif value2 == '66' then
        setTextString("big1", 'сладких апельси')
    elseif value2 == '67' then
        setTextString("big1", 'сладких апельсинов?')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '68' then
        setTextString("big1", 'вслу')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '69' then
        setTextString("big1", 'вслух')
    elseif value2 == '70' then
        setTextString("big1", 'вслух рас')
    elseif value2 == '71' then
        setTextString("big1", 'вслух рассказ')
    elseif value2 == '72' then
        setTextString("big1", 'вслух рассказов')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '73' then
        setTextString("big1", 'вслух рассказов длин')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '74' then
        setTextString("big1", 'вслух рассказов длинных?')
        setTextColor("big1", "ff2c2c")
    end
    if value2 == '75' then
        setTextString("big1", 'О')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '76' then
        setTextString("big1", 'Опять')
    elseif value2 == '77' then
        setTextString("big1", 'Опять мне')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '78' then
        setTextString("big1", 'Опять мне ка')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '79' then
        setTextString("big1", 'Опять мне каже')
    elseif value2 == '80' then
        setTextString("big1", 'Опять мне кажется')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '81' then
        setTextString("big1", 'Что')
    elseif value2 == '82' then
        setTextString("big1", 'Что кру')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '83' then
        setTextString("big1", 'Что кружи')
    elseif value2 == '84' then
        setTextString("big1", 'Что кружится')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '85' then
        setTextString("big1", 'Что кружится го')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '86' then
        setTextString("big1", 'Что кружится голо')
    elseif value2 == '87' then
        setTextString("big1", 'Что кружится голова')
        setTextColor("big1", "ff2c2c")
    end
    if value2 == '88' then
        setTextString("big1", 'Не')
        setTextColor("big1", "ff2c2c")
    elseif value2 == '89' then
        setTextString("big1", 'Не за')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '90' then
        setTextString("big1", 'Не заме')
    elseif value2 == '91' then
        setTextString("big1", 'Не замеча')
    elseif value2 == '92' then
        setTextString("big1", 'Не замечаю')
        setTextColor("big1", "ff2c2c")
    end
end

-- Русские субтитры для Pigful
if songName == 'pig-ful'  and eventName == 'lyr2' then

    if value2 == '1' then
        setTextString("big1", 'Ва')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '2' then
        setTextString("big1", 'Вадим!')
        setTextColor("big1", "ff2c2c")
    end

    if value2 == '3' then
        setTextString("big1", 'А')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '4' then
        setTextString("big1", 'ААА')
    elseif value2 == '5' then
        setTextString("big1", 'АААЛ')
    elseif value2 == '6' then
        setTextString("big1", 'АААЛЛЛ')
    elseif value2 == '7' then
        setTextString("big1", 'АААЛЛЛЁ')
    elseif value2 == '8' then
        setTextString("big1", 'АААЛЛЛЁЁЁ')
        setTextColor("big1", "ff2c2c")
    end

    if value2 == '9' then
        setTextString("big1", 'У')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '10' then
        setTextString("big1", 'У те')
    elseif value2 == '11' then
        setTextString("big1", 'У тебя бу')
    elseif value2 == '12' then
        setTextString("big1", 'У тебя буди')
    elseif value2 == '13' then
        setTextString("big1", 'У тебя будиль')
    elseif value2 == '14' then
        setTextString("big1", 'У тебя будильник!')
        setTextColor("big1", "ff2c2c")
    end

    if value2 == '15' then
        setTextString("big1", 'Е')
        setTextColor("big1", "FFFFFF")
    elseif value2 == '16' then
        setTextString("big1", 'ЕБЛА')
    elseif value2 == '17' then
        setTextString("big1", 'ЕБЛАН!')
        setTextColor("big1", "ff2c2c")
    end

end
end

function onStepHit()
    if songName == 'the-girl-from-apartment-42-v2' and curStep == 1 then
    setTextSize("big1", 140)
    end
if songName == 'the-girl-from-apartment-42-v2' and curStep == 132 then
        setTextSize("big1", 90)
end
if songName == 'the-girl-from-apartment-42-v2' and curStep == 2176 then
        setTextSize("big1", 140)
end
end
