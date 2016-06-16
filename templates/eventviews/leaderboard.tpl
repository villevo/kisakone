{**
 * Suomen Frisbeegolfliitto Kisakone
 * Copyright 2009-2010 Kisakone projektiryhmä
 * Copyright 2013-2015 Tuomo Tanskanen <tuomo@tanskanen.org>
 *
 * Leaderboard
 *
 * --
 *
 * This file is part of Kisakone.
 * Kisakone is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Kisakone is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Kisakone.  If not, see <http://www.gnu.org/licenses/>.
 * *}
 {if $mode == "head"}

<style type="text/css">{literal}
    .resultrow td, .resultrow th {
        border-right: 1px solid black;
        border-bottom: 1px solid black;
        text-align: center;
        margin: 0;
    }

    .results td, .results th {
        background-color: #EEE;
        text-align: center;
        border: 2px solid white;
    }

    .round_selection_table .selected {
        background-color: #DDD;
    }

    .results {
        border-collapse: collapse;
    }

    .rightside {
        text-align: right !important;
    }

    .leftside {
        text-align: left !important;
    }

    .sdtd {
        background-color: white !important;
    }

    .sd {
        background-color: #EEE !important;
        font-weight: bold;
        min-width: 16px;
    }

{/literal}</style>
{else}
 <div id="event_content">
    {$page->formattedText}
</div>

{if $pdgaUrl}
<div id="pdga_link">
    <a href="{$pdgaUrl}">{translate id=event_pdga_results_url}</a>
</div>
{/if}

{assign var=extrahead value=$xtrahead}
<p class="preliminary" style="display: none">
    {translate id=preliminary_results}
</p>
<div class="results_raw">
<table class="results narrow">
{foreach from=$resultsByClass key=class item=results}
    <tr style="border: none">
        {math assign=colspan equation="5+x" x=$numRounds}
        <td colspan="{$colspan}" style="background-color: white" class="leftside">
            <a name="c{$class}"></a>
            <h3>{$class|escape}</h3>
        </td>
    </tr>
    {counter assign=rowind start=-1}
    {foreach from=$results item=result}
        {counter assign=rowind}

        {if $rowind == 0}
            <tr>
                <td style="height: 8px; background-color: white;"></td>
            </tr>

            <tr class="thr">
                <th>{translate id=result_pos}</th>
                <th>{translate id=result_name}</th>

                <th>{translate id=clubname}</th>

                <th>PDGA</th>
                {if $pdga_enabled}
                <th>{translate id=pdga_rating}</th>
                {/if}
                {foreach from=$rounds key=index item=round}
                    {math assign=roundNumber equation="x+1" x=$index}
                    <th>{translate id=round_number_short number=$roundNumber}</th>
              <!--      <th>HCP{$roundNumber}</th> -->
                {/foreach}
				{if $event->levelId != 2}<th>{translate id=leaderboard_hole}</th> {/if}
                <th>+/-</th>
                <th>{translate id=result_cumulative}</th>
                {if $includePoints}
                <th>{translate id=result_tournament}</th>
                {/if}
            </tr>
            <tr>
                <td style="height: 8px; background-color: white;"></td>
            </tr>
        {/if}

        {assign var=country value=$result.PDGACountry}
        {if !$country}{assign var=country value='FI'}{/if}
        <tr class="resultrow">
            <td id="r{$result.PlayerId}_pos">{$result.Standing}</td>
            <td class="leftside"> {if $result.Username}<a href="{url page=user id=$result.Username}">{$result.FirstName|escape|replace:' ':'&nbsp;'}&nbsp;{$result.LastName|escape|replace:' ':'&nbsp;'} </a>
												{else}
												{$result.FirstName|escape|replace:' ':'&nbsp;'}&nbsp;{$result.LastName|escape|replace:' ':'&nbsp;'} {/if}
			</td>

            <td><abbr title="{$result.ClubLongName|escape}">{$result.ClubName|escape}</abbr></td>

            <td><a href="http://www.pdga.com/player/{$result.PDGANumber|escape}">{$result.PDGANumber|escape}</a></td>
            {if $pdga_enabled}
            <td>{$result.Rating|escape}</td>
            {/if}

            {foreach from=$rounds item=round key=index}
                {assign var=roundid value=$round->id}
                {assign var=rresult value=$result.Results.$roundid.Total}
                {if !$rresult}{assign var=rresult value=0}{/if}
                <td id="r{$result.PlayerId}_{$hr_id}">{$rresult}</td>
             <!--   <td>{$result.Results.$roundid.RoundedHandicap} ({$result.Results.$roundid.CalculatedHandicap})</td> -->
            {/foreach}

			{if $event->levelId != 2}<td id="r{$result.PlayerId}_tc">{$result.TotalCompleted}</td>{/if}

            <td id="r{$result.PlayerId}_pm">{if $result.DidNotFinish}DNF{else}{$result.TotalPlusminus}{/if}</td>
            <td id="r{$result.PlayerId}_t">{if $result.DidNotFinish}DNF{else}{$result.OverallResult}{/if}</td>
            {if $includePoints}
            <td id="r{$result.PlayerId}_tp">
                {assign var=tournamentPoints value=$result.TournamentPoints}
                {if !$tournamentPoints}{assign var=tournamentPoints value=0}{/if}
                {math equation="x/10" x=$tournamentPoints}
            </td>
            {/if}
            {if $result.Results.$roundid.SuddenDeath}
            <td id="r{$result.PlayerId}_p" class="sdtd sd">{translate id=result_sd_panel}</td>
            {/if}
        </tr>
    {/foreach}
{/foreach}
</table>
</div>
<!-- Jyli Handicap: Show Handicapped results -->
	{if $event->levelId == 2}

<br />
<h2>{translate id=handicapped_results}</h2>







<div class="results_hcp">
<table class="results narrow ">
{foreach from=$resultsByClassHCP key=class item=results}
    <tr style="border: none">
        {math assign=colspan equation="5+x" x=$numRounds}
        <td colspan="{$colspan}" style="background-color: white" class="leftside">
            <a name="c{$class}"></a>
            <h3>{$class|escape}</h3>
        </td>
    </tr>
    {counter assign=rowind start=-1}
    {foreach from=$results item=result}
        {counter assign=rowind}

        {if $rowind == 0}
            <tr>
                <td style="height: 8px; background-color: white;"></td>
            </tr>
		
		
		     <tr class="thr">
                <th colspan=4 style="height: 8px; background-color: white;"></th>
                
			<!-- <th>{translate id=leaderboard_hole}</th> -->
                <th colspan=3> &#x25BC;&#8194;&#8194;&#8194; HCP &#8194;&#8194;&#8194;&#x25BC;</th>

            </tr>
			
			
		
		
		
            <tr class="thr">
                <th>{translate id=result_pos}</th>
                <th>{translate id=result_name}
				</th>
                {if $sfl_enabled}
                <th>{translate id=clubname}</th>
                {/if}
                <th>PDGA</th>
                {if $pdga_enabled}
                <th>{translate id=pdga_rating}</th>
                {/if}
                {foreach from=$rounds key=index item=round}
                    {math assign=roundNumber equation="x+1" x=$index}
                    <th>{translate id=round_number_short number=$roundNumber}</th>
                    <th>HCP{$roundNumber}</th>
                {/foreach}
			<!-- <th>{translate id=leaderboard_hole}</th> -->
                <th>+/-</th>
                <th>{translate id=result_cumulative}</th>
                {if $includePoints}
                <th>{translate id=result_tournament}</th>
                {/if}
            </tr>
            <tr>
                <td style="height: 8px; background-color: white;"></td>
            </tr>
        {/if}

        {assign var=country value=$result.PDGACountry}
        {if !$country}{assign var=country value='FI'}{/if}
        <tr class="resultrow">
            <td id="r{$result.PlayerId}_pos">{$result.HCPStanding}</td>
            <td class="leftside">{if $result.Username}<a href="{url page=user id=$result.Username}">{$result.FirstName|escape|replace:' ':'&nbsp;'}&nbsp;{$result.LastName|escape|replace:' ':'&nbsp;'} </a>
											  {else}
											  {$result.FirstName|escape|replace:' ':'&nbsp;'}&nbsp;{$result.LastName|escape|replace:' ':'&nbsp;'} {/if}
											</td>
            {if $sfl_enabled}
            <td>{$result.ClubName|escape}</td>
            {/if}
            <td><a href="http://www.pdga.com/player/{$result.PDGANumber|escape}">{$result.PDGANumber|escape}</a></td>
            {if $pdga_enabled}
            <td>{$result.Rating|escape}</td>
            {/if}

            {foreach from=$rounds item=round key=index}
                {assign var=roundid value=$round->id}
                {assign var=rresult value=$result.Results.$roundid.Total}
                {if !$rresult}{assign var=rresult value=0}{/if}
                <td id="r{$result.PlayerId}_{$hr_id}">{$rresult}</td>
                <td>{$result.Results.$roundid.RoundedHandicap} ({$result.Results.$roundid.CalculatedHandicap})</td>
            {/foreach}

         <!--   <td id="r{$result.PlayerId}_tc">{$result.TotalCompleted}</td> -->

            <td id="r{$result.PlayerId}_pm">{if $result.DidNotFinish}DNF{else}{$result.TotalPlusminusHCP}{/if}</td>
            <td id="r{$result.PlayerId}_t">{if $result.DidNotFinish}DNF{else}{$result.HandicappedTotal}{/if}</td>
            {if $includePoints}
            <td id="r{$result.PlayerId}_tp">
                {assign var=tournamentPoints value=$result.TournamentPoints}
                {if !$tournamentPoints}{assign var=tournamentPoints value=0}{/if}
                {math equation="x/10" x=$tournamentPoints}
            </td>
            {/if}
            {if $result.Results.$roundid.SuddenDeath}
            <td id="r{$result.PlayerId}_p" class="sdtd sd">{translate id=result_sd_panel}</td>
            {/if}
        </tr>
    {/foreach}
{/foreach}
</table>
<div>

{/if}
    
<!-- Jyli Handicap end -->
{/if}
