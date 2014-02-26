------------------------------------------------------------
--コードを読み易くするため、ハイフンを複数書いて区切ります。
--function内や条件式内であることが見分け易くなるように、タブを入れます。
------------------------------------------------------------

--端末の幅を取得し、_Wに代入
local _W = display.contentWidth
--端末の高さを取得し、_Hに代入
local _H = display.contentHeight

--変数
local n = 0
local circleCount = 0
local diaCount = 0
local triCount = 0
------------------------------------------------------------
------------------------------------------------------------
--背景の四角形を作成します。
local back = display.newRect(_W/2, _H/2, _W, _H)
--背景に色を付けます。
back:setFillColor(0.3, 0.6, 0.9)

------------------------------------------------------------
------------------------------------------------------------
--テキストを表示します
local Titlescore = display.newText("Score", 50, 40, nil, 30)
Titlescore:setFillColor(1, 1, 1)

--スコア表示用のテキストを作成
local Numscore = display.newText("000", 150, 40, nil, 30)
Numscore:setFillColor(1, 1, 1)

------------------------------------------------------------
------------------------------------------------------------
--円の画像を表示
local circle_0 = display.newImage("Circle _80x80.png", _W/8, _H/2)
--円に色を付けます。
circle_0:setFillColor(0.7, 0.7, 0.7)

------------------------------------------------------------
--菱形の画像を表示
local dia_0 = display.newImage("Dia_80x80.png", _W/2, _H/2)
--菱形に色を付けます。
dia_0:setFillColor(0.7, 0.7, 0.7)

------------------------------------------------------------
--三角形の画像を表示
local tri_0 = display.newImage("Triangle_80x80.png", _W *7/8, _H/2)
--三角形に色を付けます。
tri_0:setFillColor(0.7, 0.7, 0.7)

------------------------------------------------------------
------------------------------------------------------------
--円の画像を表示
local circle_1 = display.newImage("Circle _80x80.png", _W/8, 100)

------------------------------------------------------------
--菱形の画像を表示
local dia_1 = display.newImage("Dia_80x80.png", _W/2, 100)

------------------------------------------------------------
--三角形の画像を表示
local tri_1 = display.newImage("Triangle_80x80.png", _W *7/8, 100)

------------------------------------------------------------
------------------------------------------------------------
--ボタンを作成
local button = display.newImage("Button.png", _W/2, _H*4/5)
--ボタンを非表示にする
button.isVisible = false

------------------------------------------------------------
------------------------------------------------------------
--リセットボタンをタッチした時の動作
local function reset(event)
	if("ended" == event.phase)then
		n = 0
		circleCount = 0
		diaCount = 0
		triCount = 0
		
		Numscore.text = "000"
		
		circle_1.x =  _W/8
		circle_1.y =  100
		
		dia_1.x =  _W/2
		dia_1.y =  100
		
		tri_1.x =  _W *7/8
		tri_1.y =  100
		
		button:removeEventListener("touch", reset)
		button.isVisible = false
	end
end
------------------------------------------------------------
--ボタンを表示するfunction
local function visibleButton()
	button.isVisible = true
	button:addEventListener("touch", reset)
end
------------------------------------------------------------
--スコアを加算するfunction
local function addScore()
	n = n +100
	Numscore.text = n
	if(n == 300)then
		visibleButton()
	end
end

------------------------------------------------------------
------------------------------------------------------------
--circle_1をタッチした時の動作
local function onCircle(event)
	--タッチし始めた時
	if("began" == event.phase)then
		--他のオブジェクトが重なってドラッグされないようにする
		display.getCurrentStage():setFocus(event.target)
	--タッチしてドラッグしている時
	elseif("moved" == event.phase)then
		circle_1.x = event.x
		circle_1.y = event.y

		local l,h,length_W,length_H
		
		l = event.x - (_W/8)
		length_W = math.abs( l )
		
		h = event.y - (_H/2)
		length_H = math.abs( h )
			
		if( (length_W < 30) and (length_H < 30) )then
			circleCount = circleCount +1
			transition.to( circle_1, { time=500, x= _W/8, y= _H/2 })
			--最初の一回のみスコアを加算
			if(circleCount == 1)then
				addScore()
			end
		end	
	--タッチし終わった時
	elseif("ended" == event.phase)then
		display.getCurrentStage():setFocus(nil)
	end
end

--circle_1をタッチイベントの対象に設定する
circle_1:addEventListener("touch", onCircle)
------------------------------------------------------------
--dia_1をタッチした時の動作
local function onDia(event)
	--タッチし始めた時
	if("began" == event.phase)then
		--他のオブジェクトが重なってドラッグされないようにする
		display.getCurrentStage():setFocus(event.target)
	--タッチしてドラッグしている時
	elseif("moved" == event.phase)then
		dia_1.x = event.x
		dia_1.y = event.y
		local l,h,length_W,length_H
		
		l = event.x - (_W/2)
		length_W = math.abs( l )
		
		h = event.y - (_H/2)
		length_H = math.abs( h )
			
		if( (length_W < 30) and (length_H < 30) )then
			diaCount = diaCount +1
			transition.to( dia_1, { time = 500, x = _W/2, y = _H/2 })
			--最初の一回のみスコアを加算
			if(diaCount == 1)then
				addScore()
			end
		end
	--タッチし終わった時
	elseif("ended" == event.phase)then
		display.getCurrentStage():setFocus(nil)
	end
end

--dia_1をタッチイベントの対象に設定する
dia_1:addEventListener("touch", onDia)
------------------------------------------------------------
--tri_1をタッチした時の動作
local function onTri(event)
	--タッチし始めた時
	if("began" == event.phase)then
		--他のオブジェクトが重なってドラッグされないようにする
		display.getCurrentStage():setFocus(event.target)
	--タッチしてドラッグしている時
	elseif("moved" == event.phase)then
		tri_1.x = event.x
		tri_1.y = event.y
		local l,h,length_W,length_H
		
		l = event.x - (_W *7/8)
		length_W = math.abs( l )
		
		h = event.y - (_H/2)
		length_H = math.abs( h )
			
		if( (length_W < 30) and (length_H < 30) )then
			triCount = triCount +1
			transition.to( tri_1, { time = 500, x = _W *7/8, y = _H/2 })
			--最初の一回のみスコアを加算
			if(triCount == 1)then
				addScore()
			end
		end
	--タッチし終わった時
	elseif("ended" == event.phase)then
		display.getCurrentStage():setFocus(nil)
	end
end

--tri_1をタッチイベントの対象に設定する
tri_1:addEventListener("touch", onTri)
------------------------------------------------------------
