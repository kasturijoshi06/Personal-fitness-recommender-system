(clear)
(reset)
(import nrc.fuzzy.*)
(import nrc.fuzzy.jess.*)

; These are the global fuzzy variables

(defglobal ?*purpose* = (new nrc.fuzzy.FuzzyVariable "purpose" 0.0 10.0 "Weight loss/gain"))
(defglobal ?*inches* = (new nrc.fuzzy.FuzzyVariable "inches" 0.0 300 "Inches"))
(defglobal ?*weight* = (new nrc.fuzzy.FuzzyVariable "weight" 0.0 600 "Kilograms"))
(defglobal ?*fats* = (new nrc.fuzzy.FuzzyVariable "fats" 0.0 200 "Kilograms"))

(defglobal ?*inchesweightloss* = (new nrc.fuzzy.FuzzyVariable "opt1" 1.0 5.0 ""))
(defglobal ?*inchesweightgain* = (new nrc.fuzzy.FuzzyVariable "opt2" 1.0 5.0 ""))


(defglobal ?*weightweightloss* = (new nrc.fuzzy.FuzzyVariable "opt3" 1.0 5.0 ""))
(defglobal ?*weightweightgain* = (new nrc.fuzzy.FuzzyVariable "opt4" 1.0 5.0 ""))


(defglobal ?*fatloss* = (new nrc.fuzzy.FuzzyVariable "opt5" 1.0 5.0 ""))
(defglobal ?*fatgain* = (new nrc.fuzzy.FuzzyVariable "opt6" 1.0 5.0 ""))


(defglobal ?*lowallweightloss* = (new nrc.fuzzy.FuzzyVariable "opt7" 1.0 5.0 ""))
(defglobal ?*highallweightloss* = (new nrc.fuzzy.FuzzyVariable "opt8" 1.0 5.0 ""))


(defglobal ?*lowallweightgain* = (new nrc.fuzzy.FuzzyVariable "opt9" 1.0 5.0 ""))
(defglobal ?*highallweightgain* = (new nrc.fuzzy.FuzzyVariable "opt10" 1.0 5.0 ""))



; This is the initial rule that initializes the different possibilities of each
; fuzzy variable

(defrule startup
    =>
    (load-package nrc.fuzzy.jess.FuzzyFunctions) 
    (?*purpose* addTerm "weightloss" (create$ 0.0 5.0) (create$ 1.0 0.0) 2)
    (?*purpose* addTerm "weightgain" (create$ 5.0 10.0) (create$ 0.0 1.0) 2)
    (?*inches* addTerm "low" (create$ 0.0 5.0) (create$ 1.0 0.0) 2)
    (?*inches* addTerm "high" (create$ 5.0 15.0) (create$ 0.0 1.0) 2)
    (?*weight* addTerm "low" (create$ 0.0 20) (create$ 1.0 0.0) 2)
    (?*weight* addTerm "high" (create$ 20 60) (create$ 0.0 1.0) 2)
    (?*fats* addTerm "low" (create$ 0.0 5) (create$ 1.0 0.0) 2)
    (?*fats* addTerm "high" (create$ 5 20) (create$ 0.0 1.0) 2)
    
    (?*weightweightloss* addTerm "lowweightloss" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*weightweightloss* addTerm "highweightloss" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*weightweightgain* addTerm "lowweightgain" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*weightweightgain* addTerm "highweightgain" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (?*inchesweightloss* addTerm "lowinchesloss" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*inchesweightloss* addTerm "highinchesloss" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*inchesweightgain* addTerm "lowinchesgain" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*inchesweightgain* addTerm "highinchesgain" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    
    (?*fatloss* addTerm "lowfatloss" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*fatloss* addTerm "highfatloss" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    (?*fatgain* addTerm "lowfatgain" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*fatgain* addTerm "highfatgain" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    
    (?*lowallweightloss* addTerm "lowall" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*highallweightloss* addTerm "highall" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (?*lowallweightgain* addTerm "lowall" (create$ 1 2.5) (create$ 1.0 0.0) 2)
    (?*highallweightgain* addTerm "highall" (create$ 2.5 5) (create$ 0.0 1.0) 2)
    
    (assert (initDone))
    )

; Once the fuzzy variables are initialized, the user is prompted for input using this rule
; Then based on user input, this rule creates necessary facts for recommendation

(defrule ask_user
    (initDone)
    =>
  (printout t " " crlf)
  (printout t " " crlf)
  (printout t "WELCOME TO YOUR PERSONAL FITNESS APP!. I am here to help you!" crlf)
  (printout t "Please type your name and press Enter> ")
  (bind ?name (readline))
  (printout t crlf "##################################################" crlf)
    (printout t "Hello, " ?name "." crlf)
    (printout t " " crlf)
  
    (printout t "Please answer the following questions and we will suggest the right activity for you." crlf)
    (printout t crlf)
    (printout t "What is your purpose?( weightloss or weightgain):" crlf)
	(bind ?ml (readline))
    (printout t "Do you want to have a low/high inches loss or inches gain?( low or high):" crlf)
    (bind ?pt (readline))
    (printout t "Do you want to have a low/high weight loss or gain?( low or high):" crlf)
    (bind ?cb (readline))
    (printout t "Do you want to have a low/high fats loss or gain?( low or high):" crlf)
    (bind ?ft (readline))
    
	(assert (purpose (new nrc.fuzzy.FuzzyValue ?*purpose* ?ml)))
    (assert (inches (new nrc.fuzzy.FuzzyValue ?*inches* ?pt)))
    (assert (weight (new nrc.fuzzy.FuzzyValue ?*weight* ?cb)))
    (assert (fats (new nrc.fuzzy.FuzzyValue ?*fats* ?ft))))
;  rule are combination of purpose, inches, fats and weight.


; Rule 1
(defrule Weightloss_Low_All_gain
    
    (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt7 (new nrc.fuzzy.FuzzyValue ?*lowallweightloss* "lowallweightloss")))
    )


; Rule 2
(defrule Weigtloss_high_inches_gain
	
   (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt1 (new nrc.fuzzy.FuzzyValue ?*inchesloss* "highinchesloss")))
    )

; Rule 3
(defrule Weighloss_high_weight_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt3 (new nrc.fuzzy.FuzzyValue ?*weightweightloss* "highweightloss")))
    )


; Rule 4
(defrule Weightloss_high_fat_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt5 (new nrc.fuzzy.FuzzyValue ?*fatloss* "highfatloss")))
    )


; Rule 5
(defrule Weightloss_low_fat_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt5 (new nrc.fuzzy.FuzzyValue ?*fatsloss* "lowfatloss")))
    )


; Rule 6
(defrule Weightloss_low_weight_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt3 (new nrc.fuzzy.FuzzyValue ?*weightweightloss* "lowweightloss")))
    )


; Rule 7
(defrule Weightloss_low_inches_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt1 (new nrc.fuzzy.FuzzyValue ?*inchesweightloss* "lowinchesloss")))
    )


; Rule 8
(defrule Weightloss_All_high_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightloss"))
    (inches ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt8 (new nrc.fuzzy.FuzzyValue ?*highallweightloss* "highallloss")))
    )

; Rule 9
(defrule Weightgain_All_low_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inches ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt9 (new nrc.fuzzy.FuzzyValue ?*lowallweightgain* "lowallgain")))
    )


; Rule 10
(defrule Weightgain_high_inches_gain
	
   (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inches ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt2 (new nrc.fuzzy.FuzzyValue ?*inchesweightgain* "highinchesgain")))
    )


; Rule 11
(defrule Weightgain_high_weight_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inches ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt4 (new nrc.fuzzy.FuzzyValue ?*weightweightgain* "highweightgain")))
    )

; Rule 12
(defrule Weightgain_high_fat_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inchess ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt6 (new nrc.fuzzy.FuzzyValue ?*fatgain* "highfatgain")))
    )

; Rule 13
(defrule Weightgain_low_fat_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inches ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "low"))
    =>
    (assert (opt6 (new nrc.fuzzy.FuzzyValue ?*fatloss* "lowfatgain")))
    )


; Rule 14
(defrule Weightgain_low_weight_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inchess ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "low"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt4 (new nrc.fuzzy.FuzzyValue ?*weightweightgain* "lowweightgain")))
    )


; Rule 15
(defrule Weightgain_low_inches_gain
	
    (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inches ?c&:(fuzzy-match ?c "low"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt2 (new nrc.fuzzy.FuzzyValue ?*inchesweightgain* "lowinchesgain")))
    )


; Rule 16

(defrule Weightgain_high_all_gain
	
	
    (purpose ?f&:(fuzzy-match ?f "weightgain"))
    (inches ?c&:(fuzzy-match ?c "high"))
    (weight ?a&:(fuzzy-match ?a "high"))
    (fats ?b&:(fuzzy-match ?b "high"))
    =>
    (assert (opt10 (new nrc.fuzzy.FuzzyValue ?*highallweightgain* "highallgain")))
    )


(defrule Activity_suggest1
    (opt7 ?i&:(fuzzy-match ?i "lowallweightloss"))
    =>
	
    (printout t "You can go for a 30-40 minute jogging session daily or take a one hour walk daily." crlf))


(defrule Activity_suggest2
    (opt1 ?i&:(fuzzy-match ?i "highinchesloss"))
    =>
    (printout t "You can do cardio exercises and eat more chia seeds, beans and legumes" )
	
)

	

(defrule Activity_suggest3
    (opt3 ?j&:(fuzzy-match ?j "highweightloss"))
    =>
   (printout t "You can jog for an hour and increase fruits and vegetables in your diet." crlf))


 
    
(defrule Activity_suggest4
    (opt5 ?k&:(fuzzy-match ?k "highfatloss"))
    =>
    (printout t "You can do high-intensity cardio exercises for one hour and cut down all sugar from your diet." crlf))


(defrule Activity_suggest5
    (opt5 ?ll&:(fuzzy-match ?ll "lowfatloss"))
    =>
    (printout t "You can do brisk walking for an hour and increase your intake of flaxseed,avacado and green tea." crlf))



(defrule Activity_suggest6
    (opt3 ?ll&:(fuzzy-match ?ll "lowweightloss"))
    => (printout t "You can do cardio and weight training in the gym and eat more green vegetables." crlf))

    
(defrule Activity_suggest7
    (opt1 ?ll&:(fuzzy-match ?ll "lowinchesloss"))
    =>
     (printout t "You can walk for 30-40 mins and eat more pineapple and lemon juice." crlf))


(defrule Activity_suggest8
    (opt8 ?i&:(fuzzy-match ?i "highallloss"))
    =>
     (printout t "You can do swimming, play basketball or do high intensity cardio for more than an hour. Eat multigrain cereal, cut down all sugar and stop eating junk food." crlf))
	 


(defrule Activity_suggest9
    (opt9 ?i&:(fuzzy-match ?i "lowallgain"))
    =>
    (printout t "You can take a short walk and eat more beef,Salmon and drink more milk ." crlf))


(defrule Activity_suggest10
    (opt2 ?i&:(fuzzy-match ?i "highinchesgain"))
    =>
    (printout t "You can 3-5 meals a day and eat more egg, chicken breast and turkey meat." crlf))



(defrule Activity_suggest11
    (opt4 ?j&:(fuzzy-match ?j "highweightgain"))
    =>
   (printout t "You can do weight training at least 3 times a week." crlf))
   

    
(defrule Activity_suggest12
    (opt6 ?k&:(fuzzy-match ?k "highfatgain"))
    =>
    (printout t "You can eat more protein and fried chicken. Do weight training with compound movement." crlf))
	


(defrule Activity_suggest13
    (opt6 ?ll&:(fuzzy-match ?ll "lowfatgain"))
    =>
    (printout t "You can drink more smoothies and shakes and do low-intensity cardio exercises." crlf))
	


(defrule Activity_suggest14
    (opt4 ?ll&:(fuzzy-match ?ll "lowweightgain"))
    => (printout t "You can play badminton and eat more yogurt." crlf))
	

	
    
(defrule Activity_suggest15
    (opt2 ?ll&:(fuzzy-match ?ll "lowinchesgain"))
    =>
     (printout t "You can buy do squats, bench presses and eat more greens such as spinach." crlf))
	 


(defrule Activity_suggest16
    (opt10 ?i&:(fuzzy-match ?i "highallgain"))
    =>
     (printout t "You can eat nut butter and do weight training daily." crlf))


(run)