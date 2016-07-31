
<h3>Pelaajan {$userinfo->fullname|escape} tasoituksen määräytyminen</h3>
Pelaajalta {$userinfo->fullname|escape} löytyy <b>{$hcpinfo.found|escape}</b> kpl Tasoituksellisia kierroksia joten tämän hetkisen pelaajatasoituksen
{if $hcpinfo.used == 0} on 0.0.{/if}
{if $hcpinfo.used == 1} laskentaan käytetään parasta kierrosta.{/if}
{if $hcpinfo.used > 1} laskentaan käytetään {$hcpinfo.used|escape} parasta kierrosta.{/if}
<br>
{if $hcpinfo.used > 0}
<div style="width: 150px;" >
<table class="fraction" align="center" cellpadding="0" cellspacing="0">
    <tr>

        <td nowrap="nowrap" style="min-width: 20px;">{$hcpinfo.used_hcps}</td>
		
		<td rowspan="2" nowrap="nowrap" style="vertical-align: middle !important;">
                x 0,96 <b>= {if $player->hcp|escape > 0 }+{/if}{$player->hcp|escape} </b> 
        </td>
    </tr>
    <tr>
        <td class="upper_line">
            {$hcpinfo.used|escape}
        </td>
    </tr>
</table>
</div>
 {if $hcpinfo.limited}
	Pelaajan tasoitus on rajoitettu suurimpaan arvoon eli +26.
{/if}

{else}
<br>
<br>
{/if}
<h3>Tasoituskierrokset</h3>
<table border="0" style="border-spacing:0px">
    <tr >
		<th class="hcpinfo_header">Päivämäärä</th>
		<th class="nowrap hcpinfo_header">Kilpailun nimi</th>
		<th class="hcpinfo_header">Rata</th>
		<th class="nowrap hcpinfo_header">Pelattu luokassa</th>
		<th class="hcpinfo_header">Tulos (+/-)</th>
		<th class="hcpinfo_header">Sijoutus</th>
		<th class="hcpinfo_header" width=30px></th>
		<th class="nowrap hcpinfo_header">Kierroksella käytetty tasoitus(Tarkka)</th>       
		<th class="hcpinfo_header">Kierrokselta tuleva tasoitus</th>
		<th class="nowrap hcpinfo_header">Radan Rating/slope</th>

    </tr>
   {foreach from=$UserHCPevents item=event}
        <tr>
		            <td style="padding-bottom: 5px;">{$event->roundtime|date_format:"%e.%m.%Y"}</td>

            </td>
            <td> <span class="nowrap"><a href="{url page='event' id=$event->eid}">{$event->eventname|escape}
               </span>
				</td>
            <td class="nowrap">{$event->coursename|escape}</td>
            <td style="text-align: center;" class="nowrap">{$event->playedclass|escape}</td>
            <td class="nowrap" style="text-align: center;">{if $event->dnf == 1}DNF {else}{$event->score|escape} ({if $event->scoreplusminus > 0 }+{/if}{$event->scoreplusminus|escape}){/if}</td>
			
			<td class="nowrap"><a href="{url page='event' view=leaderboard id=$event->eid}">
                    <img src="{$url_base}images/trophyIcon.png" alt="{translate id=results_available}" title="{translate id=results_available}"/>  {$event->standing}. sija</a>
			</td>
			<td></td>			
			<td class="nowrap table_hcp_events_hcp">{if $event->hcp_used > 0 }+{/if}{$event->rounded_hcp_used|escape} ({if $event->hcp_used > 0 }+{/if}{$event->hcp_used|escape})</td>
			
			<td class="nowrap table_hcp_events_hcp">{if $event->dnf == 1}- {else}<abbr class="player_abbr"title="Laskettu kaavalla: ({$event->score|escape} - {$event->courserating|escape}) * (80 / {$event->courseslope|escape}) = {if $event->round_hcp > 0 }+{/if}{$event->round_hcp|escape}">{if $event->round_hcp > 0 }+{/if}{$event->round_hcp|escape}</abbr>{/if}</td>									
	
			<td class="nowrap table_hcp_events_hcp">{$event->courserating|escape} / {$event->courseslope|escape}</td>			
		


        </tr>
        {foreachelse}
        <tr><td colspan="10">
            <p>Pelaajalla ei ole pelattuna tasoituksellisia kilpailuja, pelaaja saa tasoituksen ensimmäisen tasoitetun viikkokisan jälkeen.</p>
        </td></tr>
    {/foreach}
</table>
<h2> Tasoituksen määräytyminen</h2>
<table>
<tr>
<td>
<h4>Pelaajan tasoitus</h4>
	<ul>
		Pelaajantasoitus muodostuu kierroksilta tulevista <i>kierrostasoituksista.</i><br>
		<p class="hcpinfo">Pelaajantasoitus = Parhaiden kierrostasoitusten keskiarvo  x 0,96</p>
		Laskennassa käytetään pelaajan 1-10 parasta kierrostasoitusta riippuen pelattujen kierrosten määrästä(taulukko oikealla)
		<br>
		Tasoitusjärjestelmän suurin tasoitus on 26, eli tätä isompaa pelaajatasoitusta järjestelmä ei anna.
		<br>
		<br>
		Tasoituksellisessa kisassa tasoituskisan tulokset: Tasoitustulos = heitetty tulos - pelaajantasoitus.
		<br>
		Tasoituksellisten kilpailujen Leaderboard sivulla alimmaisena on tasoituskisan tulokset. Tasatuloksissa voittaa suuremman tasoituksen omaava pelaaja. 
	</ul>
<h4>Kierrostasoituksen määräytyminen</h4>

	<ul>Lyhyesti: eri rata antaa eri tasoituksen riippuen radalle asetetuista tasoitus-arvoista, jos tarkempi tieto kiinnostaa niin foliohattu päähän ja lue sivu loppuun.
	<br><br>
	
	Tasoitusjärjestelmän keskeisenä osana on radalle asetettavat tasoitus-arvot joiden avulla tasoitusjärjestelmän käyttö eri radoilla on mahdollista. 
	<br>
	Toistaiseksi vain Toramo ja Patokoski on asetettu tasoituksellisiksi radoiksi.
	<br>
	<p class="hcpinfo">Kaava kierrostasoituksen laskennassa =(Tulos - Rating) * (80 / Slope )</p>
	<br><br>
	Rataa koskevia arvoja on kaksi, Rating ja Slope:
	<br>
	<li><b>Rating</b> = luku joka kuvaa radan vaikeutta ja luku on se tulos millä radalta saa tasoituskierroksen 0. Rating luku on olennaisin muuttuja kaavassa.
	<br>Toramon osalta tämä luku on 67 eli sama kuin radan par.
	<br>Patokoski x2:n osalta tämä luku on 48 eli sama kuin 6 alle par.
	toisin sanoen toramolla tulos Par on yhtä hyvä kuin patokoskella tulos -6 (kahdelta kierrokselta).
	</li>
	<br>
	<li><b>Slope</b> = luku joka kuvaa radan vaikeutta tai siis antaa kerrointa lisää/vähemmän kun heitetty tulos eroaa Ratingista. Joillakin radoilla plussaa tulee helpommin kuin toisilla(Puistorata vs metsärata, pitkät väylät vs. lyhyet väylät tai tiheät metsät vs harvat metsät.)
	Perusarvo on 80, joka on toramon Slope arvo joten Toramolla Slope ei vaikuta.
	<br>
	Patokosken slope on 70 koska rata on helppo.
	<br>
	<br>
	Patokoski on helppo rata jolla ei tule helposti isoja lukemia joten jos heität +10 patokoskella niin eikö se ole tosi huonosti? slope arvolla saadan kaavan kautta kerrointa 80/70 = 1.14 jolloin tasoituskierrokseksi tuloksella +10 patokoskella tulee (64 - 48) * (80 / 70) =  18,2
	Slope arvo vaikuttaa siis eniten huonosti heittäneille pelaajille koska se vaikuttaa kertoimen muodossa: esim. 2*1,14-tapauksessa vaikutus on pieni mutta 16*1,14-tapauksessa vaikutus on isompi.
	<br>	
	<br>
	Muutama esimerkki radoilta tulevista tasoituksista:
	<table border="1" cellpadding="0" cellspacing="0" style="width: 200px; text-align: center;">
		<tr>
			<th></th>
			<th colspan=2 style="white-space: nowrap;">Radalta tuleva tasoitus</th>
		</tr>
		<tr>
			<th>tulos</th>
			<th>Toramo</th>
			<th style="white-space: nowrap;" >Patokoski x2</th>
		</tr>

		<tr>
			<td>-6</td>
			<td>-6</td>
			<td>0</td>
		</tr>
		<tr>
			<td>par</td>
			<td>0</td>
			<td>6,8</td>
		</tr>
		<tr>
			<td>5</td>
			<td>5</td>
			<td>12,5</td>
		</tr>
		<tr>
			<td>10</td>
			<td>10</td>
			<td>18,2</td>
		</tr>
		<tr>
			<td>20</td>
			<td>20</td>
			<td>29,7</td>
		</tr>
</table>
</ul>


</td>
<td style="width: 300px;">
	<table border="1" cellpadding="0" cellspacing="0" style="width: 200px; border-style: hidden;     text-align: center;">
		<tr>
			<th>Tasoituskierroksia</th>
			<th>Käytettävien kierrosten määrä</th>
		</tr>
		<tr>
			<td>1-3</td>
			<td>1</td>
		</tr>
		<tr>
			<td>4-6</td>
			<td>2</td>
		</tr>
		<tr>
			<td>7-8</td>
			<td>3</td>
		</tr>
		<tr>
			<td>9-10</td>
			<td>4</td>
		</tr>
		<tr>
			<td>11-12</td>
			<td>5</td>
		</tr>
		<tr>
			<td>13-14</td>
			<td>6</td>
		</tr>
		<tr>
			<td>15-16</td>
			<td>7</td>
		</tr>
		<tr>
			<td>17</td>
			<td>8</td>
		</tr>
		<tr>
			<td>18</td>
			<td>9</td>
		</tr>
		<tr>
			<td>19 ja yli</td>
			<td>10</td>
		</tr>
	</table>
</td>
</tr>
</table>


<script type="text/javascript">
//<![CDATA[
{literal}
$(document).ready(function(){
    $($(".SortHeading").get(0)).click();
});

{/literal}
//]]>
</script>