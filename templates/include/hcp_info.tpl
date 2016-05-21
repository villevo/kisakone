


<br><br>
<h3>Pelaajan {$userinfo->fullname|escape} tasoituskierrokset</h3>
<table border="0" style="border-spacing:0px">
	<!--<tr>
	<td colspan=7></td>
		<td colspan=3 class="table_hcp_events_hcp">HCP</td>
	</tr>-->
    <tr class="border_bottom">
		<th>Päivämäärä</th>
		<th class="nowrap">Kilpailun nimi</th>
        <th>Rata</th>
		<th class="nowrap">Pelattu luokassa</th>
		<th>Tulos (+/-)</th>
		<th>Sijoutus</th>
		<th width=30px></th>
		<th class="nowrap">Kierroksella käytetty tasoitus(Tarkka)</th>       
		<th class="">Kierrokselta tuleva tasoitus</th>
		<th class="nowrap ">Radan Rating/slope</th>

    </tr>
   {foreach from=$events item=event}
        <tr>
		            <td style="padding-bottom: 5px;">{$event->roundtime|date_format:"%e.%m.%Y"}</td>

            </td>
            <td> <span class="nowrap"><a href="{url page='event' id=$event->eid}">{$event->eventname|escape}
               </span>
				</td>
            <td class="nowrap">{$event->coursename|escape}</td>
            <td style="text-align: center;">{$event->playedclass|escape}</td>
            <td class="nowrap" style="text-align: center;">{$event->score|escape} ({if $event->scoreplusminus > 0 }+{/if}{$event->scoreplusminus|escape})</td>
			
			<td><a href="{url page='event' view=leaderboard id=$event->eid}">
                    <img src="{$url_base}images/trophyIcon.png" alt="{translate id=results_available}" title="{translate id=results_available}"/>  {$event->standing}. sija</a>
			</td>
			<td></td>			
			<td class="nowrap table_hcp_events_hcp">{if $event->hcp_used > 0 }+{/if}{$event->rounded_hcp_used|escape} ({if $event->hcp_used > 0 }+{/if}{$event->hcp_used|escape})</td>
			
			<td class="nowrap table_hcp_events_hcp"><abbr class="player_abbr"title="Laskettu kaavalla: ({$event->score|escape} - {$event->courserating|escape}) * (80 / {$event->courseslope|escape})">{if $event->round_hcp > 0 }+{/if}{$event->round_hcp|escape}</abbr></td>									
	
			<td class="nowrap table_hcp_events_hcp">{$event->courserating|escape} / {$event->courseslope|escape}</td>			
		


        </tr>
        {foreachelse}
        <tr><td colspan="4">
            <p>Pelaajalla ei ole pelattuna tasoituksellisia kilpailuja.</p>
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
		<br><span style="background: lightgray; padding: 5px; border-radius: 5px;">Pelaajantasoitus = Parhaiden kierrostasoitusten keskiarvo  x 0,96</span><br><br>
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

	<ul>
	Tasoitusjärjestelmän keskeisenä osana on radalle asetettavat tasoitus-arvot joiden avulla tasoitusjärjestelmän käyttö eri radoilla on mahdollista. 
	<br>
	Toistaiseksi vain Toramo ja Patokoski on asetettu tasoituksellisiksi radoiksi.
	<br>
	<br><span style="background: lightgray; padding: 5px; border-radius: 5px;">Kaava kierrostasoituksen laskennassa =(Tulos - Rating) * (80 / Slope ) </span><br>
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
	Perusarvo on 80, joka on toramon Slope arvo.
	Patokosken slope on 70.
	<br>
	Patokoski on helppo rata jolla ei tule helposti isoja lukemia joten jos heität +10 patokoskella niin eikö se ole tosi huonosti? slope arvolla saadan kaavan kautta kerrointa 80/70 = 1.14 jolloin tasoituskierrokseksi tuloksella +10 patokoskella tulee (64 - 48) * (80 / 70) =  18,2
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