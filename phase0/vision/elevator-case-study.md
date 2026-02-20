# The elevator case study

This case study applies the Phase0 derivation chain to a single domain: an elevator system in a building. It demonstrates how one conditional goal produces a rich ecosystem of actors, each traceable through tensions back to a primary actor's values.

This is not a use case specification. There are no scenarios or step-by-step flows here. This is an actor model — the actors, their goals, their drives, and the genealogy that justifies each one's existence.

---

## The system

The system under design is an elevator in a building. The elevator carries people between floors.

The elevator is not an actor. It is the system under design — the thing being built, not a participant using it. Floors are not actors. They have no goals. These are common mistakes students make when first modeling this domain: they reach for the nouns that are physically prominent rather than the nouns that have goals.

The test for actor-hood: does this entity pursue a goal and make decisions in service of that goal? The elevator does not pursue goals. Floor 12 does not pursue goals. The person standing inside the elevator does.

---

## The primary actors

This system has three primary actors. The Passenger is the person the system exists to transport. The State is the entity whose interest in public welfare shapes what the system is allowed to be. The Architect is the person who selects and specifies the elevator system for the building.

### The Passenger

The **Passenger** is the person the system exists to serve.

Students often begin with "rider." Rider is the right instinct — it names the general case. But rider is a starting point for noun refinement, not a finished actor name. Each specialization carries different value conditions, but they share a common desired end state: be on a different floor. The general case — the actor whose goal defines what the system *is* — is the Passenger.

### Passenger specializations

Passengers specialize. Each specialization shares the Passenger's desired end state but adds or intensifies specific value conditions. Several natural groupings emerge.

**Accessibility Passengers** share a pattern: same goal, but a physical or sensory constraint the standard interface does not serve. The Blind Passenger, Wheelchair Passenger, Deaf Passenger, Elderly Passenger, Passenger on Crutches, Pregnant Passenger, and Service Animal Handler all belong to this group. They are the Passengers the State's equity value protects. Each has a different constraint, but the category matters because it names the group whose value conditions the Accessibility Regulator enforces.

**Institutional Passengers** share a different pattern: someone else controls their movement, and their presence creates constraints beyond their own goal. The Hospital Patient, Prisoner, and Juror do not operate the elevator themselves. They are moved through it. Their value conditions are extreme but their agency is minimal.

**Load Pattern Passengers** have ordinary individual goals but their collective patterns are what create the throughput tension. The Hotel Guest, Office Worker, Event Attendee, and Shift Worker are why the Scheduler exists — not because of any one member, but because of the group.

**Blind Passenger.** Same goal, but the "without trauma" value intensifies — they cannot read the floor numbers on the panel. The elevator company puts braille on the buttons. Maybe the government forces them to. Either way, the Blind Passenger's value conditions create a tension that the standard interface does not resolve.

**Wheelchair Passenger.** Same goal, but physical access to the controls is constrained. The elevator company mounts the control panel low enough for a seated person to reach the top floors. Now every other Passenger is inconvenienced by a weirdly low panel. The Wheelchair Passenger's value conditions reshape the system for everyone.

**First Responder.** A specialized Passenger whose goal shifts from "be on a different floor comfortably" to "reach the emergency floor immediately." Their value conditions prioritize speed and override authority over comfort. The First Responder's urgency overrides the value conditions of every other Passenger in the building. First Responders specialize further — each sub-type has distinct value conditions that shape the system differently.

**Firefighter.** First Responder specialization. Needs fire service mode — a key-operated override that takes the elevator out of normal service and gives the Firefighter exclusive control over which floors it visits. The Firefighter may also need to evacuate people via the elevator, reversing the normal relationship: now the Firefighter is operating the system, not just riding it. Their value conditions are speed, exclusive control, and the ability to override every other actor's claim on the elevator.

**EMT.** First Responder specialization. Needs to reach a medical emergency floor quickly, then bring a patient back down — possibly on a stretcher. Their value conditions add space (the stretcher must fit) and hold (the elevator must stay at the floor while they load). An EMT's return trip has different constraints than their arrival: speed down, stability matters, and the doors must accommodate a gurney.

**Police Officer.** First Responder specialization. Needs access during security incidents. Their value conditions may include floor lockdown — preventing the elevator from stopping at certain floors — or surveillance priority. The Police Officer's interaction with the system is about control and restriction, not just transportation. They may need to prevent *other* Passengers from reaching a floor, which directly conflicts with every other Passenger's goal.

**Child.** Too short to reach upper-floor buttons. Same desired end state, but a physical constraint that the standard interface does not accommodate. The Child's value conditions also intensify safety — doors that close too fast, a cabin that moves with no adult present, an emergency phone mounted too high.

**Hotel Guest.** A specialized Passenger whose usage patterns cluster predictably — up in the evening, down in the morning. Their promptness value creates scheduling demand distinct from office patterns. The Hotel Guest does not need a different interface. They need the system to anticipate where they are going.

**Office Worker.** The inverse pattern — down in the morning, up in the evening. Hotel Guest and Office Worker are why the Scheduler exists. Different populations create different throughput demands, and the Passenger's promptness value cannot be satisfied without someone optimizing for those patterns.

**Delivery Person.** A specialized Passenger carrying goods rather than just themselves. Their value conditions add space, door timing, and possibly freight access. A Delivery Person with a hand truck needs doors that stay open longer and a cabin that fits the load. Same desired end state — be on a different floor — but the physical constraints reshape what "promptly" and "safely" mean.

**VIP.** A specialized Passenger who adds *privacy* to the base value conditions. A celebrity in a hotel, an executive in a tower. They do not want to share the cabin or the floor access with the general population. This is why penthouse elevators exist — dedicated cars that serve only restricted floors. The VIP's privacy value creates a tension with every other Passenger's promptness value: a dedicated elevator serving one person is an elevator unavailable to everyone else.

**Visitor.** A specialized Passenger who needs floor access without permanent credentials. Their goal is the same — be on a different floor — but the system does not know them. The Visitor creates a tension with every security measure: the system must let them in without compromising the controls that keep unauthorized people out. Visitor badges, temporary floor access, escort requirements — all exist because of this tension between legitimate temporary access and persistent security.

**Stranded Passenger.** A Passenger whose goal has fundamentally changed. They no longer want to be on a different floor. They want to *get out*. The elevator has stopped between floors, or the doors will not open, or the power has failed. The Stranded Passenger's value conditions are: safely (do not make it worse), promptly (do not leave me here), and without trauma (communicate with me so I know help is coming). The red emergency phone exists because of this actor. The Stranded Passenger spawns their own supporting actors — someone must answer that phone, someone must come get them out.

**Deaf Passenger.** Same goal, but the "without trauma" value intensifies around communication. The Deaf Passenger cannot hear floor announcements, alarms, or emergency intercom communication. If the elevator stops between floors, the Blind Passenger can hear the intercom — the Deaf Passenger cannot. The system needs visual emergency communication, visual floor indicators, and visual alarms. A different design demand from the Blind Passenger's braille, though both trace to the same value condition.

**Elderly Passenger.** Slower movement, balance concerns, longer door timing needed. The standard door-close speed is calibrated for able-bodied adults. The Elderly Passenger needs more time to enter and exit. Their "safely" value intensifies around the doors specifically — the doors are the most dangerous part of the system for someone who moves slowly. Their "promptly" value may actually relax — they would rather wait than rush.

**Passenger on Crutches.** Temporary disability, distinct from the Wheelchair Passenger. They are standing, so the panel height is not the issue. The issue is balance and door timing. They need handrails and doors that do not close while they are mid-stride. A temporary condition — they will not always need these accommodations — but the system must serve them while they do.

**Pregnant Passenger.** Needs stability, may need to sit, may have urgency. The "without trauma" value intensifies around sudden stops and crowded cabins. Some elevators have fold-down seats — that design decision traces to this actor. The Pregnant Passenger's condition is temporary but the system must accommodate it as a permanent design feature.

**Parent with Stroller.** Space requirements similar to the Wheelchair Passenger but the tension is different. The parent must manage a stroller *and* a child. Door timing is critical — they cannot sprint through closing doors. They also cannot easily use stairs as a fallback, which makes the elevator not a convenience but a necessity. Their "promptly" value conflicts with their need for slower doors.

**Service Animal Handler.** A Passenger with a working animal — guide dog, psychiatric support animal. The animal changes the space calculation and creates a tension with other Passengers who may be allergic or afraid. The Service Animal Handler's legal right to access conflicts with other Passengers' comfort. The State's equity value backs the Service Animal Handler; the other Passengers' "without trauma" value pushes back.

**Mover.** Needs to monopolize the elevator entirely. Pads on the walls, doors held open for extended periods, freight mode if available. Every minute the Mover holds the elevator is a minute it is unavailable to everyone else. Their "promptly" value directly trades off against every other Passenger's. The Mover is why some buildings have dedicated freight elevators — a system design decision spawned by the tension between the Mover's need to monopolize and everyone else's need for access.

**Hospital Patient.** Being transported between floors, often on a gurney, often unable to operate controls. The Patient does not choose to ride the elevator — they are being moved. Their "without trauma" and "safely" values are extreme because they are medically vulnerable. Distinct from the EMT (who transports them) and the Hospital Administrator (who controls floor access). The Patient's condition may make even normal elevator operation dangerous — sudden stops, vibration, tilting during acceleration.

**Prisoner.** In a courthouse or detention facility. Must be escorted, must be kept separate from the public, floors must be secured during transport. The Prisoner's movement through the elevator system is controlled by others. Their presence creates a hard security constraint — the elevator cannot stop at public floors while transporting a Prisoner. The Prisoner's presence overrides every other Passenger's goal, similar to the Firefighter but for security rather than emergency.

**Juror.** In a courthouse, must be kept separate from defendants and witnesses. Different from the Prisoner — the Juror has freedom but must be routed to avoid contact with parties to the case. Their value condition is not physical safety but judicial integrity. The system must prevent accidental encounters — an elevator design problem that most buildings never face.

**Event Attendee.** A concert hall, convention center, or stadium. Mass arrival and departure create extreme load spikes that dwarf normal office or hotel patterns. The Event Attendee's "promptly" value collides with thousands of other Event Attendees' identical value, all at the same moment. This load pattern is what drives the design of bank elevators — multiple cars in parallel, express service to specific floors, skip-stop patterns.

**Shift Worker.** In a factory or hospital. Shift changes create predictable but intense load patterns at non-standard hours. Different from the Office Worker's 9-to-5 pattern. The system must handle 3 AM shift changes with the same throughput it handles the morning rush. The Shift Worker's existence means the Scheduler cannot assume normal business hours.

**Night Passenger.** Alone in the building after hours. The "safely" and "without trauma" values intensify around security and isolation. An empty elevator at 2 AM in a parking garage is a different experience than a crowded elevator at noon. The Night Passenger may need surveillance cameras, better lighting, emergency call features, or restricted access that daytime Passengers never think about. Their value conditions reshape what "safe" means when no one else is around.

**Claustrophobic Passenger.** The "without trauma" value is dominant and may override "promptly." They may refuse to enter a full elevator. They may panic during delays or stops between floors. The system's standard behavior — closing doors, sealed cabin, movement between floors, occasional stops — is itself the threat. Glass-walled elevators, larger cabins, faster travel times, and reliable operation all trace partly to this actor's value conditions.

### Cultural specializations

The Passenger's value conditions are universal — every Passenger wants safety, promptness, comfort, and physical integrity. But culture determines which value *dominates*, and that weighting produces entirely different elevator systems from the same set of values.

**American Passenger.** Promptness dominates. American elevators move fast — fast enough that ears pop during ascent. The acceleration is aggressive, the doors close quickly, the system is optimized for throughput. The American Passenger tolerates physical discomfort as the price of speed. "Without trauma" is present but subordinate to "promptly." The engineering reflects this: powerful motors, fast door actuators, aggressive scheduling algorithms. The Manufacturer building for the American market optimizes for speed because that is what this Passenger values most.

**Japanese Passenger.** Comfort dominates. Japanese elevators are engineered for the feeling of zero acceleration — the ride is so smooth you barely know you are moving. The "without trauma" value extends beyond emergency scenarios to the physical sensation of normal operation. A Japanese Passenger who feels their knees compress during deceleration has experienced a design failure. The engineering is more sophisticated: variable-speed drives, precision leveling, damped door mechanisms. Promptness matters, but not at the cost of ride quality. The ride quality *is* the product.

**Russian Passenger.** Economics constrain which values can be served. Russian elevators are often cheap, harsh, and abrupt — they stop hard enough to hurt your knees. The "safely" value is met at a minimum level (the elevator works, mostly), but "without trauma" and "promptly" are sacrificed to cost. This is not a different set of values — the Russian Passenger would prefer a smooth, fast ride. It is a different economic reality. The Owner's economic drive (or the State's economic constraints) dominate so thoroughly that the Passenger's comfort values cannot find expression in the system design. The same value conditions exist. The budget does not allow them to be served.

These cultural specializations are important because they show that the conditional goal framework does not assume a particular weighting. The values are universal. The priorities are contextual. A Manufacturer who builds the same elevator for Tokyo, New York, and Moscow has misunderstood three different Passengers.

### The State

The **State** is the second primary actor. The State does not ride the elevator. The State's interest is that elevators in its jurisdiction do not kill, injure, trap, or exclude its citizens.

The State's conditional goal: *public welfare is protected — safely, equitably, accountably.*

- **Safely** — citizens are not harmed by elevators. Mechanical standards, inspection regimes, and emergency protocols exist because of this value.
- **Equitably** — all citizens can use the system, regardless of disability. Accessibility mandates exist because of this value. The braille on the buttons for the Blind Passenger, the low panel for the Wheelchair Passenger — the elevator company may not have done these voluntarily. The State's equity value is what forces the issue.
- **Accountably** — the people who build, install, maintain, and operate elevators are licensed, inspectable, and answerable. The State does not trust self-regulation. Its accountability value demands that every actor in the chain can be audited.

The State's values create their own derivation chain, independent of the Passenger's. The Passenger wants to be on a different floor. The State wants elevators to not harm people. These goals overlap but they are not the same — and they spawn different supporting actors.

### The Architect

The **Architect** is the third primary actor. The Architect selects and specifies the elevator system for the building.

The Architect's conditional goal: *the building has the correct elevator system — efficiently, safely, within budget, to code.*

- **Efficiently** — the system handles the building's traffic patterns without excessive wait times or wasted capacity. The Architect must predict how many elevators the building needs, where the shafts go, and what capacity each car must handle.
- **Safely** — the system meets safety standards. The Architect's safety value overlaps with the State's but is not identical. The Architect internalizes safety as a professional obligation. The State enforces it as a public mandate.
- **Within budget** — the Owner is paying. The Architect's design must be economically viable. This value creates a tension with the Passenger's promptness value (more elevators cost more) and the State's equity value (accessibility features cost more).
- **To code** — the design must satisfy the Code Authority. The Architect does not set the codes. The Architect works within them. But the Architect also exercises professional judgment — codes are minimums, not design targets.

The Architect is both a primary actor (with their own goal and value conditions) and a supporting actor of the Passenger (whose promptness value the Architect's design serves) and the State (whose codes the Architect's design must satisfy). This dual role is not a modeling error. It reflects the reality that the Architect has genuine design authority — they make decisions, not just execute instructions.

---

## The conditional goals

### The Passenger's conditional goal

*Be on a different floor — safely, promptly, without trauma, with all my limbs.*

The desired state is "be on a different floor." Not "arrive at a new floor" — that leaks an implementation detail. It implies travel. The real end state is *being* on a different floor. If a genie could teleport the Passenger, the goal is satisfied. This is the [gift test](conditional-goals.md#the-gift-test): if a shortcut that skips the described action still satisfies the goal, you have written a goal. If the shortcut would not satisfy, you have written a task.

"Get to floor 12" is a task, not a goal. The real goal includes what the Passenger values about being in that state:

- **Safely** — physical protection during the process
- **Promptly** — reasonable waiting and travel time
- **Without trauma** — psychological comfort; no terror, no uncertainty
- **With all my limbs** — physical integrity; no catastrophic mechanical failure

A Passenger who reaches floor 5 missing an arm did not achieve their goal. Physical integrity was part of what they valued, not an optional extra bolted on by an engineer.

### The State's conditional goal

*Public welfare is protected — safely, equitably, accountably.*

The desired state is "public welfare is protected." The State does not ride the elevator. The State does not care which floor anyone is going to. The State cares that elevators in its jurisdiction do not kill, injure, trap, or exclude its citizens.

- **Safely** — citizens are not harmed by elevators. Mechanical standards, inspection regimes, and emergency protocols exist because of this value.
- **Equitably** — all citizens can use the system, regardless of disability. The braille on the buttons, the low panel, the audio announcements — the elevator company may not have done these voluntarily. The State's equity value is what forces the issue.
- **Accountably** — the people who build, install, maintain, and operate elevators are licensed, inspectable, and answerable. The State does not trust self-regulation. Its accountability value demands that every actor in the chain can be audited.

---

## Tensions

Value conditions collide with reality. Each collision is a tension. Each tension either spawns a supporting actor or is acknowledged as unresolved.

**Safety vs. economics.** Elevators cost money. Someone owns them and pays for their maintenance. That owner has an economic drive — minimize cost. The Passenger's safety value collides with the owner's incentive to defer maintenance, use cheaper parts, and skip inspections. This tension demands resolution by a party whose drive is not economic.

**Promptness vs. capacity.** A building has a finite number of elevators serving a variable number of passengers. Morning rush sends everyone down; evening rush sends everyone up. The Passenger's promptness value collides with physical constraints on throughput. This tension demands someone who optimizes movement patterns.

**Psychological comfort vs. operational reality.** Elevators break down. Power fails. Doors stick. These events threaten the Passenger's "without trauma" value. The tension between the Passenger's expectation of a controlled experience and the reality of mechanical systems demands maintenance standards, emergency protocols, and communication during delays.

**Physical integrity vs. mechanical failure.** The Passenger's "with all my limbs" value demands engineering constraints that prevent catastrophic failure. A spec says "elevator must not free-fall." A value says "I don't want to lose my limbs." The spec is one implementation of the value. You can satisfy the value in ways the spec never imagined. Designing from values keeps the solution space open. Designing from specs closes it prematurely.

**Accessibility vs. security.** The Passenger's base goal is "be on a different floor." But not everyone should be able to reach every floor. Tenants want controlled access to their space. Hospitals need to restrict pharmacy and psychiatric floors. Data centers require biometric authentication. Every security measure is a constraint on someone else's access — a direct tension with the Passenger's transportation goal. This is not one tension but a family of tensions around the question: who should be able to reach which floor, and why? Each answer spawns different actors with different drives.

### Tensions from the State's values

The State's conditional goal creates its own set of tensions, independent of the Passenger's.

**Safety vs. self-regulation.** The State's safety value collides with the Owner's economic drive and the Manufacturer's commercial drive. Neither the Owner nor the Manufacturer can be trusted to regulate themselves — their drives pull toward cost reduction and sales volume, not public protection. This tension demands an inspection regime and the actors to carry it out.

**Equity vs. economics.** Accessibility features cost money. Braille panels, low-mounted controls, audio announcements, wider doors — each one adds cost that the Owner would prefer to avoid and the Manufacturer would prefer not to engineer. The State's equity value collides with every economic actor's drive. This tension is what produces accessibility mandates — the State forces the issue because the market will not resolve it voluntarily.

**Accountability vs. autonomy.** Every actor in the elevator chain — the Architect who designs the shaft, the Manufacturer who builds the car, the Installer who puts it in, the Maintainer who keeps it running, the Operator who runs it daily — would prefer to operate without oversight. The State's accountability value collides with this preference. This tension spawns licensing boards, certification requirements, and audit regimes. The State demands that every actor in the chain can be inspected and held answerable.

---

## Supporting actors

Each supporting actor exists because a tension demands them. Each has a drive — their reason to participate — and a genealogy that traces back to a specific value condition on a primary actor's goal.

**Owner.** Drive: economic interest. The Owner exists because elevators cost money. Someone must own, operate, and maintain them. The Owner's drive alone is insufficient to protect every value the Passenger holds. That insufficiency is what spawns other supporting actors. Owners specialize — and the specialization changes the shape of the tensions.

**Commercial Building Owner.** Owner specialization. Drive: minimize operating cost, maximize property value. Serves many Passengers they do not know personally. The tension between their economic drive and the Passenger's safety value is at its sharpest here — they are balancing cost against liability, tenant satisfaction, and regulatory compliance across a large population of strangers. This is the Owner that most clearly spawns the Inspector.

**Home Owner.** Owner specialization. Drive: personal cost vs. personal convenience. A wealthy individual with an elevator in their house. The Home Owner *is* the Passenger — or their family is. The tension between Owner and Passenger partially collapses because the economic drive and the safety value live in the same person. But only partially. They still might defer maintenance to save money. They are still not qualified to inspect their own work. The insufficiency remains — it is just harder to see because the two roles share a body.

**Landlord.** Owner specialization. Drive: property value and tenant retention. The Landlord owns a residential building. Their Passengers are tenants with a legal relationship — not strangers passing through and not family. A broken elevator is not just an inconvenience; it is a lease violation, a liability, a reason tenants leave. The Landlord's economic drive is shaped by tenant retention in a way the Commercial Building Owner's is not.

**Hotel Owner.** Owner specialization. Drive: guest experience as revenue. A broken elevator loses bookings. The Hotel Owner's economic drive is more aligned with the Passenger's promptness and comfort values than other Owner types — not because they care more, but because their revenue depends directly on the Passenger's experience. The tension between economics and safety still exists, but the economics pull *toward* Passenger satisfaction rather than away from it.

**Inspector.** Drive: safety compliance — verify that the elevator meets mechanical and operational standards. The Inspector is an agent of the State. The State's safety value collides with the Owner's economic drive and the Manufacturer's commercial drive; neither can be trusted to self-regulate. The Inspector resolves this tension on the State's behalf. The Inspector does not exist because "regulations require inspections." The Inspector exists because the State's safety value *demands* a party whose drive is verification, not economics. The regulation is an implementation detail. The tension is the modeling concept. Inspectors specialize by when and why they inspect.

**Annual Inspector.** Inspector specialization. Drive: routine verification — confirm the elevator still meets standards after a year of operation. The Annual Inspector's relationship to the system is periodic and comprehensive. They check everything on a schedule. Their drive is ongoing compliance — catching degradation before it becomes dangerous.

**Witness Inspector.** Inspector specialization. Drive: test verification — observe specific tests (load tests, speed tests, safety device tests) and certify the results. The Witness Inspector does not examine the whole system. They watch a specific test performed by the Maintainer or Commissioning Technician and verify it was done correctly and the results meet standards. Their drive is narrower than the Annual Inspector's but deeper — they see one thing in full detail.

**Accident Investigator.** Inspector specialization. Drive: root cause analysis — determine what went wrong after an incident. The Accident Investigator shows up after the Stranded Passenger has been rescued, after the injury has been treated, after the failure has been contained. Their drive is entirely different from the other Inspectors': not compliance and not verification, but explanation. They need to know *why* it failed so the State can prevent it from happening again. The Accident Investigator may discover that the Annual Inspector missed something, that the Maintainer cut a corner, or that the Manufacturer's design had a latent flaw.

**Scheduler.** Drive: efficiency — optimize throughput. Spawned by the Passenger's promptness value colliding with building capacity. This is why hotels bias upper floors in the evening and offices bias lower floors in the morning. The Scheduler's drive is not safety or cost — it is throughput.

**Operator.** Drive: operational continuity — keep the system running day-to-day. The Operator runs the system. Their drive is distinct from the Owner's (economic) and the Maintainer's (repair). The Operator ensures the elevator is available, responds to routine issues, and manages the daily rhythm of the system. Operators specialize by how they interact with the system.

**Elevator Attendant.** Operator specialization. Drive: personal service — physically operate the elevator for Passengers. The Elevator Attendant pushes the buttons, controls the doors, and manages who enters and exits. Still exists in luxury buildings, historic hotels, and some freight elevators. The Attendant mediates between the Passenger and the system — the Passenger never touches the controls. Their drive is service, not throughput. The Attendant is why some elevators have manual door controls and operator panels distinct from the Passenger panel.

**Remote Monitoring Operator.** Operator specialization. Drive: surveillance and dispatch — monitor multiple buildings from an offsite location. Their relationship to the system is entirely mediated by the Monitoring and Control Software Engineer's work. They see dashboards, receive alerts, and dispatch Maintainers or Emergency services. The Remote Monitoring Operator may manage dozens of buildings simultaneously. Their failure mode is different from the on-site Operator's: they cannot walk to the machine room. Everything they know comes through the screen.

**Building Engineer.** Operator specialization. Drive: whole-building systems management — oversee all building systems, elevators being one among many. The Building Engineer's scope is broader than the elevator Operator's. They manage HVAC, electrical, plumbing, fire systems, and elevators as an integrated whole. Their drive is building-level operational continuity, not elevator-specific. They are the person the Integration Engineer's work must satisfy — the one who sees how the elevator interacts with everything else in the building.

**Maintainer.** Drive: mechanical reliability — prevent and repair failures. The Maintainer exists because the Passenger's physical integrity and psychological comfort values demand a functioning machine. The Maintainer's drive is repair and prevention, not economics (Owner) or regulatory compliance (Inspector). Maintainers specialize by when and why they intervene.

**Preventive Maintainer.** Maintainer specialization. Drive: scheduled prevention — service the system on a regular cycle to prevent failures before they happen. Oil the rails, test the brakes, replace the worn cables, calibrate the leveling. The Preventive Maintainer's relationship to the system is periodic and proactive. They are the reason the elevator does not break down, which means their success is invisible. When they do their job well, nothing happens.

**Emergency Maintainer.** Maintainer specialization. Drive: rapid restoration — get the elevator running again after a breakdown. Distinct from the Rescue Technician (who extracts the Stranded Passenger) and the Preventive Maintainer (who prevents breakdowns). The Emergency Maintainer arrives after the Rescue Technician has gotten people out and fixes the machine itself. Their drive is restoration, not extraction and not prevention.

**Modernization Specialist.** Maintainer specialization. Drive: renewal — upgrade aging systems to current standards and capabilities. An elevator that still passes annual inspection but runs on 1970s relay logic and has no monitoring capability is this actor's domain. The Modernization Specialist exists at the boundary between maintenance and replacement. Their drive is distinct from the Preventive Maintainer's (who keeps the current system running) and the Manufacturer's (who builds new systems). The Modernization Specialist extends the life of existing systems by bringing them closer to current expectations — the Japanese Passenger's zero-acceleration standard applied to a building that was designed for the American Passenger's speed-first standard.

**Architect.** Drive: spatial and structural design — determine how many elevators, where the shafts go, what capacity they handle. The Architect is spawned by the Passenger's promptness value meeting the physical constraints of the building. The Architect makes decisions *before the system exists* that constrain everything downstream. A building with two elevators serving forty floors is a different system than one with six elevators serving ten. The Architect's choices are upstream of the Scheduler's — the Scheduler optimizes within constraints the Architect set.

**Manufacturer.** Drive: engineering and commercial — design and sell a product that works. The Passenger's physical integrity value demands someone who designs fail-safes: redundant cables, emergency brakes, overspeed governors. The Manufacturer is distinct from the Maintainer (who keeps it running after installation) and the Inspector (who verifies it meets standards). The Manufacturer's drive includes a commercial dimension — they want to sell elevators — but the Passenger's values constrain what they can sell.

**Tenant.** Drive: controlled access to their space. An office tenant on floor 20 does not want anyone off the street riding up to their reception. The Tenant's drive is not transportation — it is space protection. They need the elevator to know who is authorized for which floors. The Tenant's access-control drive directly conflicts with the general Passenger's goal of reaching any floor. This tension is what produces key card systems, floor-restricted access, and lobby security checkpoints.

**Residential Tenant.** Tenant specialization. Drive: home security. The tension is sharper than the commercial Tenant's — this is where they live, not just where they work. The Residential Tenant does not want strangers riding to their floor. Key fob access, restricted floors. Their drive is personal safety in a way that the office Tenant's is not.

**Security Guard.** Drive: access enforcement — control who gets to go where in real time. Spawned by the tension between the Passenger's goal of reaching any floor and the Tenant's goal of restricting access. The Security Guard is the person in the lobby who decides. Distinct from the Police Officer (emergency authority), the Building Manager (policy), and the Tenant (whose space is being protected). The Security Guard enforces rules that others set.

**Building Manager.** Drive: access policy — decide which tenants get access to which floors, which visitors need escorts, what hours the rules change. Distinct from the Security Guard (who enforces) and the Owner (who pays). The Building Manager creates the rules. The Security Guard executes them. The Owner funds the infrastructure that makes them possible.

**Hospital Administrator.** Drive: patient safety through floor restriction. Certain floors must be locked down — the pharmacy, the psychiatric ward, the NICU. The reason is not commercial privacy. It is patient safety and drug security. A hospital elevator that lets anyone reach the pharmacy floor has failed a security obligation that has nothing to do with the Passenger's transportation goal. The Hospital Administrator's drive is distinct from the commercial Tenant's — different regulatory framework, different stakes, different consequences for failure.

**Data Center Operator.** Drive: extreme access control. If the building has a data center floor, the access requirements go beyond key cards — biometric authentication, access logging, escort policies, audit trails. The Data Center Operator's security drive is more intense than any other Tenant type and operates under regulatory frameworks (SOC 2, HIPAA, government classification) that override the building's normal access policies.

The Inspector, Accessibility Regulator, Code Authority, Licensing Board, and Fire Marshal are all **Regulatory Agents** — agents of the State with different scopes. They share a genealogy root (the State's values) but branch on which value they enforce: safety, equity, or accountability. The Regulatory Agent category matters because it names the mechanism by which the State's values become operational. The State does not inspect elevators. The State creates Regulatory Agents who do.

**Accessibility Regulator.** Drive: equitable access — ensure all citizens can use the elevator regardless of disability. An agent of the State, spawned by the State's equity value colliding with the Owner's economic drive and the Manufacturer's commercial drive. Accessibility features cost money. Without the Accessibility Regulator, the braille panels, low-mounted controls, audio announcements, and wider doors may never appear. The Accessibility Regulator does not ride the elevator. They mandate that it works for everyone.

**Code Authority.** Drive: standards enforcement — ensure buildings are designed and constructed to code. An agent of the State, spawned by the State's safety and accountability values colliding with the Architect's design autonomy and the Owner's economic drive. The Code Authority defines how many elevators a building needs, where shafts can go, what fire ratings the doors must have, how much load the system must handle. The Architect works within constraints the Code Authority sets. The Code Authority works within values the State holds.

**Licensing Board.** Drive: professional accountability — certify that the people who build, install, maintain, and operate elevators are qualified. An agent of the State, spawned by the State's accountability value. The Manufacturer, the Installer, the Maintainer, the Operator — each must be licensed. The Licensing Board does not inspect elevators. It inspects the people who touch them. Distinct from the Inspector (who verifies the machine) and the Code Authority (who constrains the design).

**Fire Marshal.** Drive: fire safety in the built environment. An agent of the State with a narrower scope than the Inspector. The Fire Marshal cares about fire service mode, emergency recall, shaft ventilation, and the elevator's role in building evacuation. The Inspector verifies general mechanical safety. The Fire Marshal verifies the elevator's behavior during a fire — a different set of standards, a different inspection regime, and a different relationship to the Firefighter who uses fire service mode.

**Installer.** Drive: correct installation — put the elevator in according to the Manufacturer's specifications and the Code Authority's standards. The Installer exists because the Manufacturer builds the elevator but does not put it in the building. Installation is a distinct skill with distinct failure modes. A perfectly engineered elevator installed incorrectly is dangerous. The State's accountability value demands that the Installer is licensed and inspectable, separate from the Manufacturer and the Maintainer. Installers specialize — and their specializations need affordances that the Passenger never sees.

**Construction Worker.** Installer specialization. Drive: build the infrastructure — pour the pit, erect the shaft, install the guide rails. The Construction Worker operates before the elevator exists. The shaft during construction is one of the most dangerous work environments in a building — an open vertical void. The Construction Worker's value conditions are about their own safety: fall protection anchor points, temporary barriers, shaft lighting, lockout/tagout systems. These are affordances in Norman's sense — the physical environment must afford safe interaction during a phase when none of the Passenger's interfaces exist yet. The Construction Worker's safety needs shape the shaft's design in ways the Passenger will never notice.

**Elevator Installer.** Installer specialization. Drive: install the car, cables, motor, and controls correctly. The Elevator Installer works inside a partially completed shaft with heavy machinery. They need construction-mode operation — the ability to move the car at slow speed under manual control for positioning and alignment. Their affordances are different from the Construction Worker's (who builds the space) and different from the Maintainer's (who works on a completed system). The Elevator Installer needs the system to be partially operational in a way that is safe for someone standing on top of the car or inside the shaft.

**Commissioning Technician.** Installer specialization. Drive: verification — test and certify the installed system before it goes live. The Commissioning Technician exists at the boundary between installation and operation. They run the elevator through every mode — normal, fire service, emergency, overload — and verify that each behaves correctly. Their drive is distinct from the Inspector's (who verifies ongoing compliance) because the Commissioning Technician verifies *initial* correctness. A system that passes commissioning and later fails inspection has degraded. A system that fails commissioning was never right.

**Engineer.** Drive: correct design — ensure the elevator system works as intended. The Engineer exists because the Manufacturer needs someone who translates the Passenger's values, the State's standards, and the Architect's constraints into a buildable design. Engineers specialize by discipline, and each specialization has a different relationship to the system's failure modes.

**Mechanical Engineer.** Engineer specialization. Drive: structural and mechanical integrity. Designs the cables, pulleys, brakes, car structure, guide rails, counterweights, and safety devices. The Passenger's "with all my limbs" value traces most directly to this actor. The Mechanical Engineer decides how many cables, what breaking strength, what safety factor. A redundant cable is the Mechanical Engineer's answer to the Passenger's physical integrity value. Their affordance to the system is the physical design — the things you can touch.

**Electrical Engineer.** Engineer specialization. Drive: power and control integrity. Designs the motor, the power distribution, the control circuits, the emergency power systems. The Electrical Engineer's domain includes what happens when power fails — a direct connection to the Stranded Passenger. The backup battery that keeps the car lit and the intercom working during a power failure is an Electrical Engineer's design decision. Their affordance to the system is the energy — the things that make it move and think.

**Software Engineer.** Engineer specialization. Drive: control logic correctness. The Software Engineer's work mediates between every Passenger specialization and the physical system. The door timing that the Elderly Passenger needs, the fire service mode the Firefighter needs, the floor lockdown the Police Officer needs — each is a software behavior. Software Engineers specialize further because the software in an elevator is not one system — it is several systems with different lifecycles, different failure modes, and different update mechanisms.

**Firmware Engineer.** Software Engineer specialization. Drive: embedded control correctness. Writes the code that runs on the elevator's own controller — the logic that decides when to move, when to stop, when to open doors, when to engage safety brakes. Firmware is intimate with the hardware. A firmware bug can kill people. Firmware updates are a critical design problem: how do you update the code in a running elevator without creating a window where the safety interlocks are not active? The Firmware Engineer's relationship to the Passenger's physical integrity value is as direct as the Mechanical Engineer's — different medium, same stakes.

**Monitoring and Control Software Engineer.** Software Engineer specialization. Drive: system observability and remote control. Designs the software that lets the Operator see what every elevator in the building is doing — which floor, which direction, which mode, what faults. Also designs the scheduling algorithms that the Scheduler depends on. This software runs on servers or building management systems, not on the elevator itself. Its failure mode is different from firmware: if the monitoring system fails, the elevator keeps running — but the Operator goes blind and the Scheduler cannot optimize.

**Integration Engineer.** Software Engineer specialization. Drive: cross-system correctness. The elevator does not exist alone. It integrates with the building's fire control system (fire service recall), the security system (floor access control), the building management system (energy, HVAC, lighting), and possibly the emergency dispatch system. The Integration Engineer ensures these systems communicate correctly. Their failure mode is the gap between systems: the fire alarm fires but the elevator does not recall. The key card system revokes access but the elevator still stops at the restricted floor. Each integration point is a boundary where two systems must agree, and the Integration Engineer owns that agreement.

**Systems Engineer.** Engineer specialization. Drive: integrated system correctness — ensure all components work together as a whole. The Systems Engineer exists because a mechanically sound car with correct electrical power and working software can still fail as a system. The door timing interacts with the scheduling algorithm. The fire service mode interacts with the power system. The emergency phone interacts with the control logic. The Systems Engineer's drive is integration — no individual component engineer can see the whole picture. Their failure mode is the gap between disciplines: each subsystem works, but they do not work together.

**Emergency Dispatcher.** Drive: rescue coordination — get help to the Stranded Passenger. The person on the other end of the red phone. The Stranded Passenger's "promptly" and "without trauma" values demand someone who answers, assesses the situation, and dispatches the right responder. The Emergency Dispatcher does not fix the elevator. They connect the Stranded Passenger to someone who can. Distinct from the Operator (who manages daily operations) and the Maintainer (who repairs the machine).

**Rescue Technician.** Drive: extraction — get the Stranded Passenger out safely. Spawned by the Stranded Passenger's "safely" and "promptly" values. The Rescue Technician may be a specialized Maintainer, a Firefighter, or a dedicated elevator rescue professional — depending on the building and jurisdiction. Their drive is distinct from the Maintainer's (who prevents failures) and the Firefighter's (who responds to fire emergencies). The Rescue Technician responds to entrapment specifically.

**Insurance Underwriter.** Drive: risk assessment — price the probability and cost of failure. The Insurance Underwriter does not ride the elevator, inspect it, or fix it. They calculate what happens when things go wrong: the Stranded Passenger's distress, the Passenger's injury, the Owner's liability. Their risk assessments influence the Owner's maintenance decisions, the Manufacturer's design choices, and the building's safety posture. The Insurance Underwriter's drive is actuarial, not operational — but their judgments ripple through every economic decision in the system.

**Decommissioning Authority.** Drive: end-of-life determination — decide when an elevator has reached the end of its useful life and must be replaced rather than maintained or modernized. This actor fills the gap at the end of the lifecycle. The Preventive Maintainer keeps it running. The Modernization Specialist upgrades it. But at some point, the machine cannot be maintained or modernized cost-effectively, and its continued operation threatens the Passenger's values more than its removal would. The Decommissioning Authority may be the Inspector (who fails it), the Insurance Underwriter (who refuses to insure it), the Code Authority (whose updated standards it cannot meet), or a dedicated consultant. The decision to decommission is where the Owner's economic drive, the State's safety value, and the Passenger's physical integrity value converge — keeping a dangerous elevator running is cheaper than replacing it, but the other actors will not allow it.

---

## The genealogy test

Every supporting actor must pass the genealogy test: trace *why* they exist back to a specific value condition on a specific primary actor's goal.

- **Owner** ← elevators cost money; someone must fund and maintain the system. Genealogy root: the system itself requires economic participation. Specializations (Commercial Building Owner, Home Owner, Landlord, Hotel Owner) share the genealogy root but reshape the tensions — the Home Owner partially collapses the Owner/Passenger tension; the Hotel Owner's economics align with Passenger satisfaction rather than opposing it.
- **Inspector** ← State's *safety* value + Owner's economic drive create a tension that demands a non-economic verification party. The Inspector is an agent of the State. Genealogy root: State's safety.
- **Scheduler** ← Passenger's *promptness* value + building capacity constraints. Genealogy root: promptness.
- **Operator** ← the system must function daily for any value to be delivered. Genealogy root: all values (operational prerequisite).
- **Maintainer** ← Passenger's *physical integrity* and *psychological comfort* values + mechanical wear. Genealogy root: physical integrity, psychological comfort.
- **Architect** ← Passenger's *promptness* value + physical constraints of the building. Decisions made before the system exists constrain all downstream actors. Genealogy root: promptness.
- **Manufacturer** ← Passenger's *physical integrity* value demands engineered fail-safes. Genealogy root: physical integrity.
- **Tenant** ← Passenger's *safety* value, inverted: the Tenant is a Passenger on their own floor whose safety value demands that unauthorized people cannot reach them. Genealogy root: safety (from the Tenant-as-Passenger perspective).
- **Residential Tenant** ← same genealogy as Tenant, but the safety value intensifies because the space is a home. Genealogy root: safety.
- **Security Guard** ← tension between Passenger's access goal and Tenant's restriction goal demands real-time enforcement. Genealogy root: safety (Tenant's), accessibility (Passenger's).
- **Building Manager** ← same tension as Security Guard, but at the policy level rather than enforcement. Genealogy root: safety, accessibility.
- **Hospital Administrator** ← Passenger's *safety* value in a medical context: patient safety and drug security demand floor restriction. Genealogy root: safety (specialized to medical context).
- **Data Center Operator** ← Passenger's *safety* value extended to data and infrastructure: regulatory frameworks demand extreme access control. Genealogy root: safety (specialized to information security).
- **Accessibility Regulator** ← State's *equity* value + Owner's economic drive and Manufacturer's commercial drive create a tension that demands mandated accessibility. Genealogy root: equity.
- **Code Authority** ← State's *safety* and *accountability* values + Architect's design autonomy. Genealogy root: safety, accountability.
- **Licensing Board** ← State's *accountability* value demands that every person who touches an elevator is certified. Genealogy root: accountability.
- **Fire Marshal** ← State's *safety* value specialized to fire scenarios. Genealogy root: safety.
- **Installer** ← State's *accountability* value + Passenger's *physical integrity* value. Installation is a distinct skill with distinct failure modes. Specializations (Construction Worker, Elevator Installer, Commissioning Technician) share the genealogy root but operate in different phases and need different affordances. Genealogy root: accountability, physical integrity.
- **Engineer** ← Passenger's *physical integrity* and *safety* values + State's *safety* and *accountability* values demand correct design. Specializations (Mechanical, Electrical, Software, Systems) each own a different relationship to the system's failure modes. Genealogy root: physical integrity, safety.
- **Emergency Dispatcher** ← Stranded Passenger's *promptly* and *without trauma* values demand someone who answers the red phone and coordinates rescue. Genealogy root: promptness, psychological comfort (Stranded Passenger).
- **Rescue Technician** ← Stranded Passenger's *safely* and *promptly* values demand someone who physically extracts them. Genealogy root: safety, promptness (Stranded Passenger).
- **Insurance Underwriter** ← Owner's economic drive + the probability of Passenger injury or Stranded Passenger entrapment. Risk assessments influence maintenance decisions and design choices. Genealogy root: safety (indirectly, through economic pressure on the Owner).
- **Inspector specializations** (Annual Inspector, Witness Inspector, Accident Investigator) ← share the Inspector's genealogy root (State's safety) but differ in timing and purpose: ongoing compliance, specific test verification, and post-incident root cause.
- **Operator specializations** (Elevator Attendant, Remote Monitoring Operator, Building Engineer) ← share the Operator's genealogy root (all values, operational prerequisite) but differ in how they interact with the system: hands-on service, screen-mediated surveillance, whole-building scope.
- **Maintainer specializations** (Preventive Maintainer, Emergency Maintainer, Modernization Specialist) ← share the Maintainer's genealogy root (physical integrity, psychological comfort) but differ in when they intervene: before failure, after failure, at end of useful life.
- **Software Engineer specializations** (Firmware Engineer, Monitoring/Control Software Engineer, Integration Engineer) ← share the Engineer's genealogy root but own different failure modes: embedded control, system observability, cross-system boundaries.
- **Decommissioning Authority** ← convergence of Owner's economic drive, State's *safety* value, and Passenger's *physical integrity* value at end of life. Genealogy root: safety, physical integrity.

If you cannot trace the chain from a supporting actor back to a primary actor's value condition, the actor does not belong in the model. An actor without a genealogy is an assumption borrowed from an org chart — not derived from the forces at play.

---

## Common mistakes

Students modeling the elevator domain consistently make the same mistakes. Each one reveals a misunderstanding about what an actor is.

**Floors as actors.** Floor 12 has no goal. It does not pursue anything. It does not make decisions. It is a location in the system, not a participant.

**The elevator as an actor.** The elevator is the system under design. You do not model the system as an actor using itself. The elevator is what is being built. The actors are the people and roles that interact with it.

**"Get to floor 12" as a goal.** This is a task disguised as a goal. It names a destination without expressing what the Passenger values about getting there. "Be on a different floor — safely, promptly, without trauma, with all my limbs" is the goal. The destination is just one parameter.

**The Inspector as regulation.** Students often justify the Inspector by saying "regulations require inspections." This reverses the derivation. The Inspector exists because the tension between the Owner's economic drive and the Passenger's safety value demands a third party. Regulations are how society *implements* that demand. The tension is the modeling concept. The regulation is an implementation detail.

---

## Further reading

- [Conditional goals](conditional-goals.md) — the theory behind conditional goals, the gift test, the derivation chain, and the genealogy test
- [The discovery process](discovery-process.md) — how a facilitated session unfolds, in four natural rounds
