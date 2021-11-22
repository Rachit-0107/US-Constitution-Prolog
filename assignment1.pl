/* age/2 gives the age and citizen/2 gives the years of citizenship of a person */

age(rohan, 23).
citizen(rohan, 23).
age(meera, 30).
citizen(meera, 8).
age(david, 35).
citizen(david, 35).
age(leonard, 40).
citizen(leonard, 40).
age(amy, 38).
citizen(amy, 5).

stateOfUS(newHampshire).
stateOfUS(massachusetts).
stateOfUS(connecticut).
stateOfUS(newYork).
stateOfUS(newJersey).
stateOfUS(pennsylvania).
stateOfUS(delaware).
stateOfUS(maryland).
stateOfUS(virginia).
stateOfUS(northCarolina).
stateOfUS(southCarolina).
stateOfUS(georgia).

monday(7, 1, 2019).
monday(2, 12, 2019).


/*
 * NAME: Rishabh Barnwal
 * ID: 2020A7PS1677P
 */

%Article 1
%Section 1
powerDistribution(congress,  X):-
    X = senate;
    X = houseOfRepresentatives.
/* houses with power */


%Section 2
representative(X):-
    age(X, Y),
    citizen(X, Z),
    Y >= 25,
    Z >= 7.
/* prerequisites for becoming a representative of house */

qualified(X, houseOfRepresentatives):-
    representative(X).
/* a check for person being qualified */


%Section 3
senetor(Person):-
    age(Person, Age),
    citizen(Person, YearsOfCitizenship),
    Age >= 30,
    YearsOfCitizenship >= 9.
/* prerequisites for becoming a senator of house */

senate(Person1, Person2, HomeStateOfP1, HomeStateOfP2, ElectionStateOfP1, ElectionStateOfP2):-
    senetor(Person1),
    senetor(Person2),
    Person1 \= Person2,
    HomeStateOfP1 \= ElectionStateOfP1,
    HomeStateOfP2 \= ElectionStateOfP2.
/* senate comprises of 2 senetors */

impeachment(Person1, Person2, TotalMembers, MembersPresent):-
    MembersPresent >= 2/3*TotalMembers,
    Person1 = presidentOfUS,
    Person2 = chiefJustice;
    MembersPresent >= 2/3*TotalMembers,
    Person1 = _,
    Person2 = _.
/* removal of a president */

presidentOfSenate(X):-
    X = vicePresidentOfUS.


%Section 4
electingRepresentative(D,M,Y, PlaceOfMeet, Person):-
    monday(D,M,Y),
    stateOfUS(PlaceOfMeet),
    representative(Person).
/*election of a representative*/

electingSenetor(D,M,Y, PlaceOfMeet, StateOfSenetor, Person):-
    monday(D,M,Y),
    stateOfUS(PlaceOfMeet) \= stateOfUS(StateOfSenetor),
    senetor(Person).
/*election of a senator*/

meetingOfCongress(D, M, 2019):-
    monday(D, M, 2019).


%Section 5
punishMember(Attendance, CausingDisorder, TotalMembers, PresentMembers):-
    Attendance = _;
    CausingDisorder = _,
    PresentMembers >= 2/3*TotalMembers.
/*punishing member of houses*/

journalOfSecrectProceedings(TotalMembers, PresentMembers):-
    PresentMembers >= 1/5* TotalMembers.
/*updating the journal of secret proceedings*/


%Section 6
peace(breach).
peace(felony).
peace(treason).
toNotPayCompensation(Y, Person):-
    peace(Y),
    representative(Person);
    peace(Y),
    senetor(Person).


%Section 7
isApproved(yes).
noCongressAdjournament(yes).
billPassHouseOfRepresentatives(MembersPresent, TotalYes, TotalNo):-
    MembersPresent is TotalYes + TotalNo,
    TotalYes >= 2/3 * MembersPresent.
billPassSenate(MembersPresent, TotalYes, TotalNo):-
    MembersPresent is TotalYes + TotalNo,
    TotalYes >= 2/3 * MembersPresent.
/* two third majority in houses for the bill to pass */

presidentAproval(Approval, TotalMembers, TotalYes, TotalNo):-
    isApproved(Approval);
    TotalMembers is TotalYes + TotalNo,
    TotalYes >= 2/3 * ( TotalMembers ).
/* bill shall pass if it again gets passed with two third majority after president rejects it for the first time */

isLawByCongress(Adjournament):-
    noCongressAdjournament(Adjournament).
/* law will be formed if congress doesn't put adjournamanet */


%Section 8
powers(X, [X|_]).
powers(X, [_|T]):-
       powers(X,T).

collect(tax).
collect(duties).
collect(excises).
collect(debts).
/* congress can collect any form of duties */
power(X, Power):-
    (X = congress; stateOfUS(X)),
    powers(Power, [collect(tax), collect(duties), collect(excises), collect(debts), defence, warfare, borrowMoney, regulateCommerce, lawsOnBankruptcies, fixStdWeightsAndMeasures, punishmentOfCounterfeiting, coinMoney, estPostOfficeAndRoads, promoteScienceAndArts, punishPiracyAndFelony, declareWar, captureLandAndWater, raiseSupportArmy, maintainNavy, rulesAndRegulation, suppressInsurrections, repelInvasions, appointmentOfOfficersAndAuthorityOfMilitia, lettersOfMarqueAndReprisal]).
    
/* all powers that congress holds as per constitution under normal circumstances */

protectAgainstInvasion(X):-
    stateOfUs(X).
/* congress can choose to protect states against invasions */




%Section 9
consentOfCongress(yes).
officeOfProfitOrTrust(_).
canAccept(Consent, _):-
    consentOfCongress(Consent),
    officeOfProfitOrTrust(_).
/* only with congress' approval can the officers collect gifts or appraisals */


%Section 10
ifEmergence(yes).
confiscatedPowersOfState(ConfiscatedPower):-
    powers(ConfiscatedPower, [treaty, alliance, confederation, lettersOfMarqueAndReprisal, coinMoney, emitBillsOfCredit, grantTitleOfNobility]).
/* state almost has all the powers that congress provides, except these few strictly under normal circumstatnces */

powersOfState(CongressConsent, Emergence, Power):-
    consentOfCongress(CongressConsent);
    ifEmergence(Emergence),
    powers(Power, [layImposts, dutiesOnImportExport, dutyOfTonnage, keepTroops, shipsOfWar, agreementWithOtherState, engageInWar]).
/* with congress' approval or state of emergency, the state can access confiscated powers as well */




%Article 2
%Section 1:
executivePower(Person):-
    Person = "President";
    eligibility_for_president(Person).
not_elector("senator").
not_elector("representative").
not_elector(Person):-
    representative(Person);
    senator(Person).
not_elector(Person):-
    Person = "Trust and Profit Officer".

noOfElectors(NoOfSenators,NoOfRepresentative,X):-
X is NoOfSenators+NoOfRepresentative.

electionProcedure(thePersonHavingMoreVotesToPresident).
electionProceduresifEqualVotes(houseOfRepresentativeChoseByBallot).

eligibility_for_president(Person):-
    age(Person, Age),
    citizen(Person, YearsOfCitizenship),
    Age >= 35,
    YearsOfCitizenship >= 14.

reasonForRemovalOfPresident(X):-
X="Death";
X="Resignation";
X="Inability to discharge powers".

power(congress,determine_date).
power(congress,determine_time).

ifBothPresidentAndVicePresidentRemoved(congress_determine_officer_for_President).

president(hasToTakeOath).

recieveCompensation(Person):-
     Person = "President";
     eligibility_for_president(Person).

onRemovalOfPresident(InCharge):-
    InCharge = "Vice President".

%Section 2:
commanderInChiefOfArmy(Person):-
    Person = "President";
    eligibility_for_president(Person).
commanderInChiefOfNavy(Person):-
    Person = "President";
    eligibility_for_president(Person).
decisionMakingProcess(X, Y):-
X = "President",
Y = "Excecutive Officers".
/*decision making process requires president and executive officers of all departments that will be involved in the process*/

pardon(offenseAgainstUS).
grant(pardon(offenseAgainstUS)).
power(Person, grant(pardon(Pardon))):-
    citizen(Person, _),
    Pardon = offenseAgainstUS.

%Section 3:
conveneBothHouses(Person):-
    Person = "President";
    eligibility_for_president(Person).

president(recieveAmbassadors_and_public_ministers).
president(giveInformationToCongress).

%Section 4:
removedFromOfficeByImpeachment(Person):-
    eligibility_for_president(Person);
    Person = "President",
    Person = "Vice President";
    Person = "Civil Officer".
reasonForImpeachment(treason).
reasonForImpeachment(bribery).
reasonForImpeachment(highCrimes).
reasonForImpeachment(high_misdemeanors).




%Article 3
%Section 1:
judicialPower(Court1,Court2):-
    Court1 = supremeCourt,
    Court2 = inferiorCourt.
recieveCompensation(Judges):-
    Judges = "Judge of Supreme Court";
    Judges = "Judge of Inferior Court".

%Section 2:
judicialPowerOverCases(Cases):-
    Cases = "Laws of US";
    Cases = "Treaties";
    Cases = "Ambassadors";
    Cases = "Admirality";
    Cases = "Maritime";
    Cases = "Controversies".

%Section 3:
convictionForTreason(Reason):-
    Reason="TestimonyOfTwoWitness";
    Reason="confessionInOpenCourt".
declarePunishmentForTreason(houseOfCongress).




%Article 4
%Section 1
right(_,X) :- faithandcredit(X).
faithandcredit(publicacts).
faithandcredit(records).
faithandcredit(judicial_proceedinngs).

%Section 2
priviliges(_). /* priviliges are provided to all citizens */
isDemand(yes).
treason(_,X,Y) :- isDemand(X),stateOfUS(Y).  /*checks if there is a demand of the executive of state Y to get the criminal back to the state*/

%Section 3
partofstates(A,B) :- stateOfUS(A),stateOfUS(B).
addedtocongress(X) :- not(stateOfUS(X)). /* checks if a new state is already a part of an old state*/
addedtocongress(X) :- not(partofstates(A,B)). /* checks if a new state is part of 2 existing states*/
newState(X) :- addedtocongress(X). /* checks if new state can be added to congress*/
newrules(congress).
constitution(noprejudice).

%Section 4
canFormRepublicanGovernment(X) :- stateOfUS(X).
protectionAgainstInvasion(X) :- stateOfUS(X).
protectionAgainstDomesticViolence(X) :- stateOfUS(X).




%Article 5
isnecessary(yes).
lawpassed(X,A,True) :- X > Y , Y is (2*A/3), isnecessary(True). /* X members voting in favour of ammendment out of total A present and if the ammendment is necessary*/
shallpropose(X) :- isnecessary(X).
ammendment(X) :- not(unchanged(X)). /* checks if the ammendment is not one which cant be changed*/
unchanged(clause_1_section_9_article_1).
unchanged(clause_4_section_9_article_1).




%Article 6
isValidafterImplementation(debts_before_consitution_implemened).
isValidafterImplementation(engagements_before_constitution_implemented).
judgesBoundby(consitution).
judgesBoundby(lawsofanyState).
lawofLand(constitution).
boundbyOathorAffirmation(senetors).
boundbyOathorAffirmation(representatives).
boundbyOathorAffirmation(members_Of_State_Legislatures).
boundbyOathorAffirmation(executive_Officers).
boundbyOathorAffirmation(judicial_Officers).
qualificationtoOffice(no_Religious_Test).
qualificationtoPublicTrust(no_Religious_Test).




%Article 7
estalishmentofConstitution(ratification_of_Conventions_of_9_states).
doneinConvention(unanimous_Consent).
names_Of_Rep(X,[X|_]).
names_Of_Rep(X , [_|T]) :- names_Of_Rep(X,T).
newhampshire(X) :- names_Of_Rep(X,[john_Langdon,nicholas_Gilman]).
massachuttes(X) :- names_Of_Rep(X,[nathaniel_Gorham,rufus_King]).
connecticut(X) :- names_Of_Rep(X,[wm._Saml._Johnson,roger_Sherman]).
newyork(X) :- names_Of_Rep(X,[alexander_Hamilton]).
newjersey(X) :- names_Of_Rep(X,[wil:_Livingston,david_Brearley,wm._Paterson,jona:_Dayton]).
pennsylvannia(X) :- names_Of_Rep(X,[b_Franklin,thomas_Miffl_in,robt_Morris,geo._Clymer,thos._FitzSimons,jared_Ingersoll,james_Wilson,gouv_Morris]).
delaware(X) :- names_Of_Rep(X,[geo:_Read,gunning_Bedford_jun,john_Dickinson,richard_Bassett,jaco:_Broom]).
maryland(X) :- names_Of_Rep(X,[james_McHenry,dan_of_St._Thos._Jenifer,danl_Carroll]).
virginia(X) :- names_Of_Rep(X,[john_Blair,james_Madison_Jr]).
north_carolina(X) :- names_Of_Rep(X,[wm._Blount,richd._Dobbs_Spaight,hu_Williamson]).
south_carolina(X) :- names_Of_Rep(X,[j._Rutledge,charles_Cotesworth_Pinckney,charles_Pinckney,pierce_Butler]).
georgia(X) :- names_Of_Rep(X,[william_Few,abr_Baldwin]).
secretary(william_jackson).
appoint_delegates(nine_states).
nine_state_delegates(ratifyConstitution).
appointed(electors).
elected(senators).
elected(representation).
electors_assemble(electionForPresident).
transmit_votes_to(secretary).
appoint_delegates(nine_states).
nine_state_delegates(ratifyConstitution).
appointed(electors).
elected(senators).
elected(representation).
electors_assemble(electionForPresident).
transmit_votes_to(secretary).





% Amendment1
congresscannot(establish_religion_or_ban_free_exercise).
congresscannot(abridge_freedom_of_speech).
congresscannot(abridge_freedom_of_press).
congresscannot(abridge_right_to_assemble_peacefully).
congresscannot(abridge_right_to_question_govt).



% Amendment2
right(X,keep_and_bear_arms):-citizen(X,Y),Y>=18.



% Amendment3
during_peace(soldier_cannot_forcibly_quarter_in_any_house).
during_war(soldier_can_quarter_in_a_manner_given_by_law).



% Amendment4
right(X,Right):-
    Right = secured_against_unreasonable_searches_and_seizures,
    citizen(X,Y).



% Amendment5
noperson_heldto_answerfor(capital).
noperson_heldto_answerfor(infamous_crime). 
person_heldto_answerfor(presentment_of_GrandJury). 
person_heldto_answerfor(cases_arising_in_naval_forces).
person_heldto_answerfor(cases_arising_in_Militia).
noPerson(canbe_putin_jeopardytwice).
noPerson(compelled_toBe_Witness_againstSelf_in_criminalCases).
noPerson_Deprivedof(life).
noPerson_Deprivedof(liberty).
noPerson_Deprivedof(property).
privateProperty(cannot_betaken_for_publicUse).
compensationprovided(privateproperty_for_publicuse).
cannot_beputin_jeopardy_twiceof(life).
cannot_beputin_jeopardy_twiceof(limb).



% Amendment6
right_on_accusation(X,Right):-accused(X), Right = "speedy_and_public_trial".



% Amendment7
right_of_jury_in_fedral_court(cannot_reexamine_facts_in_any_court_if_amount_exceeds_20dollars).



% Amendment8
cannot_impose(excessive_fines).
cannot_give(cruel_or_unusual_punishments).



% Amendment9
right(_,cannot_be_denied_of_rights_not_written_in_constitution_by_government).



% Amendment10
right_of_states(powers_not_mentioned_in_constitution_belong_to_states_or_people_and_not_federal_government).



% Amendment11
deny_citizens_from(suing_state_in_federal_court).



% Amendment12
/* A portion of Article II, Section 1 of the Constitution was changed by the 12th Amendment */
vote_By_Ballot(Person1, Person2, StateOfPerson1, StateOFPerson2):-
    stateOfUS(StateOfPerson1),
    stateOfUS(StateOFPerson2),
    StateOfPerson1 \= StateOFPerson2,
    Person1 = "President",
    Person2 = "Vice President".
president_Of_Senate(Action, PresenceOf):-
    PresenceOf = " in the presence of the Senate and House of Representatives",
    Action = "open all the certificates and the votes shall then be counted".
if_no_person_gets_majority_for_president(Action, BeforeDay):-
    Action = "the House of Representatives shall choose immediately, by ballot, the President",
    BeforeDay = "fourth day of March".
if_house_of_representatives_fail_to_choose(Person_To_Become_President):-
    Person_To_Become_President = "vice_president".
if_no_person_gets_majority_for_vicepresident(Action):-
    Action = "the Senate shall choose the Vice-President".
/* Superseded by Section 3 of the 20th Amendment */



% Amendment13
% Section1
protection_from_slavery_and_involuntary_service(X) :- not_covicted_of_a_crime(X).

% Section2
can_enforce_this_article(congress,by_appropriate_legislation).



% Amendment14
% Section1
naturalisedInUs(_).
bornInUS(Person):-
    citizen(Person, _),
    naturalisedInUs(Person).
state_cannot(abridge_the_privileges_of_citizens_of_USA).
state_cannot(deprive_person_of_life_liberty_and_property_without_process_of_law).
state_cannot(deny_anyone_from_its_jurisdiction_equal_protection_of_laws).

% Section2
equal_right_to_vote_for_male(X) :- not_rebellion_or_criminal(X),gender(X,male),citizen(X,Y),Y>=21.

% Section3
previously_elected_candidate(X,cannot_be_chosen_again_to_support_constitution) :- rebel(X),having_less_than_two_third_votes_in_house(X).

% Section4
validity_of_public_debt(notToBeQuestioned).
obligation_Incurred_In_Rebellion_Or_Insurrection(notPaidByUnitedStates).
claim_For_Emancipation_Or_Loss_Of_Slave(notPaidByUnitedStates).
illegal_AndVoid_Obligation(Type):-
    Type="Obligation Incurred In Rebellion Or Insurrection";
    Type="Claim For Emancipation Or Loss Of Slave".

% Section5
can_enforce_this_article(congress,by_appropriate_legislation).



% Amendment15
% Section1
not_to_deny_citizen_rights(race).
not_to_deny_citizen_rights(color).
not_to_deny_citizen_rights(previous_condition_of_servitude).

% Section2
can_enforce_this_article(congress,by_appropriate_legislation).



% Amendment16
power_of_congress(to_collect_taxes_on_all_incomes_irrespective_of_Population_of_state).



% Amendment17
election_of_senator(senator_would_be_elected_by_people_of_state_and_not_state_legislature).
term_of_senator(six_years).
number_of_senator_from_each_state(2).



% Amendment18
% Section1
prohibition_of(manufacturing_transporting_and_sale_of_intoxicating_liquors_within_US).

% Section2
can_enforce_this_article(congress,by_appropriate_legislation).

% Section3
duration_for_implementing_this_article(seven_years_from_date_of_submission).



% Amendment19
not_to_deny_citizen_rights(sex).
can_enforce_this_article(congress,by_appropriate_legislation).



% Amendment20
% Section1
last_day_of_president_and_vice_president_term(january_20th).
last_day_of_house_of_representatives_and_senators_term(january_3rd).

% Section2
assembling_of_congress(atleast_once_every_year).
compulsary_date_of_assembling(january_3rd_unless_appointed_by_law_for_different_day).

% Section3



% Amendment 21
prohibited(intoxicating_liquors).



% Amendment 22
tenureOfPresident(Person, NoOfTerms):-
	eligibility_of_president(Person),
	NoOfTerms =< 2.



% Amendment 24
paid_tax(_).
right_to_vote(Person, vote) :-
	paid_tax(Person);
	\+ paid_tax(Person).



% Amendment 25
% Section 1
removal_or_dies(president).
becomes_president(vice_president) :-
	removal_or_dies(president).

% Section 2
vacancy(vice_president).
nominates(president, vice_president) :-
	vacancy(vice_president).

% Section 3
cannot_perform(president).
becomes_acting_president(vice_president) :-
	cannot_perform(president).



% Amendment 26
right(Person, X) :-
    X = vote,
	citizen(Person, Age),
	Age >= 18.



% Amendment 27
election(_).
propose(change_compensation).
change_compensation(Representatives) :-
	election(Representatives),
	propose(change_compensation).

%END



